#
#  Copyright (C) 2004 University of Valencia
#
#  This file is part of dotLRN.
#
#  dotLRN is free software; you can redistribute it and/or modify it under the
#  terms of the GNU General Public License as published by the Free Software
#  Foundation; either version 2 of the License, or (at your option) any later
#  version.
#
#  dotLRN is distributed in the hope that it will be useful, but WITHOUT ANY
#  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
#  FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
#  details.
#

ad_library {    

    Procs to set up the dotLRN quota applet

    @author Agustin Lopez (Agustin.Lopez@uv.es)
        @author Paco Soler (fransola@uv.es)
    @creation-date 2005-12-15
    @version $Id: dotlrn-quota-procs.tcl,v 0.2 2005/12/15

}

namespace eval dotlrn_quota {
    
    ad_proc -public applet_key {
    } {
        What's my applet key?
    } {
        return dotlrn_quota
    }

    ad_proc -public package_key {
    } {
        What package do I deal with?
    } {
        return quota
    }

    ad_proc -public my_package_key {
    } {
        What package do I deal with?
    } {
        return "dotlrn-quota"
    }

    ad_proc -public get_pretty_name {
    } {
        returns the pretty name
    } {
        return "[_ dotlrn-quota.pretty_name]"
    }

    ad_proc -public add_applet {
    } {
        One time init - must be repeatable!
    } {
        dotlrn_applet::add_applet_to_dotlrn -applet_key [applet_key] -package_key [my_package_key]
    }

    ad_proc -public remove_applet {
    } {
        One time destroy. 
    } {
        dotlrn_applet::remove_applet_from_dotlrn -applet_key [applet_key]
    }

    ad_proc -public add_applet_to_community {
        community_id
    } {
        Add the quota applet to a specifc dotlrn community
    } {
        set portal_id [dotlrn_community::get_portal_id -community_id $community_id]

        # create the quota package instance (all in one, I've mounted it)
        set package_id [dotlrn::instantiate_and_mount $community_id [package_key]]

        # set up the admin portal
        set admin_portal_id [dotlrn_community::get_admin_portal_id \
                                 -community_id $community_id
        ]

        quota_admin_portlet::add_self_to_page \
            -portal_id $admin_portal_id \
            -package_id $package_id
        
        set args [ns_set create]
        ns_set put $args package_id $package_id
        add_portlet_helper $portal_id $args

        return $package_id
    }

    ad_proc -public remove_applet_from_community {
        community_id
    } {
        remove the applet from the community
    } {
        ad_return_complaint 1 "[applet_key] remove_applet_from_community not implimented!"
    }

    ad_proc -public add_user {
        user_id
    } {
        one time user-specifuc init
    } {
        # noop
    }

    ad_proc -public remove_user {
        user_id
    } {
    } {
        # noop
    }

    ad_proc -public add_user_to_community {
        community_id
        user_id
    } {
        Add a user to a specifc dotlrn community
    } {
        set package_id [dotlrn_community::get_applet_package_id -community_id $community_id -applet_key [applet_key]]
        set portal_id [dotlrn::get_portal_id -user_id $user_id]

        # use "append" here since we want to aggregate
        set args [ns_set create]
        ns_set put $args package_id $package_id
        ns_set put $args param_action append
        
        #For do not appears on user personal page
        add_portlet_helper $portal_id $args        
    }

    ad_proc -public remove_user_from_community {
        community_id
        user_id
    } {
        Remove a user from a community
    } {
        set package_id [dotlrn_community::get_applet_package_id -community_id $community_id -applet_key [applet_key]]
        set portal_id [dotlrn::get_portal_id -user_id $user_id]

        set args [ns_set create]
        ns_set put $args package_id $package_id

        remove_portlet $portal_id $args
    }
        
    ad_proc -public add_portletOLD {
        portal_id
    } {
        A helper proc to add the underlying portlet to the given portal. 
        
        @param portal_id
    } {
        # simple, no type specific stuff, just set some dummy values

        set args [ns_set create]
        ns_set put $args package_id 0
        ns_set put $args param_action overwrite
        add_portlet_helper $portal_id $args
    }

    ad_proc -public add_portlet {
        portal_id
    } {
        A helper proc to add the underlying portlet to the given portal. 
        
        @param portal_id
    } {
        set args [ns_set create]
        ns_set put $args package_id 0
        set type [dotlrn::get_type_from_portal_id -portal_id $portal_id]

        if {[string equal $type "dotlrn_class_instance"] == 1} {
            add_portlet_helper $portal_id $args
        }  else {
            # not to any of the other types
            return
        }     

    }

    ad_proc -public add_portlet_helper {
        portal_id
        args
    } {
        A helper proc to add the underlying portlet to the given portal.

        @param portal_id
        @param args an ns_set
    } {
        quota_portlet::add_self_to_page \
            -portal_id $portal_id \
            -package_id [ns_set get $args package_id] \
            -param_action [ns_set get $args param_action]
    }

    ad_proc -public remove_portlet {
        portal_id
        args
    } {
        A helper proc to remove the underlying portlet from the given portal. 
        
        @param portal_id
        @param args A list of key-value pairs (possibly user_id, community_id, and more)
    } { 
        quota_portlet::remove_self_from_page \
            -portal_id $portal_id \
            -package_id [ns_set get $args package_id]
    }

    ad_proc -public clone {
        old_community_id
        new_community_id
    } {
        Clone this applet's content from the old community to the new one
    } {
        set new_package_id [add_applet_to_community $new_community_id]
        set old_package_id [dotlrn_community::get_applet_package_id \
            -community_id $old_community_id \
            -applet_key [applet_key]
        ]

        db_exec_plsql call_quota_clone {}
        return $new_package_id
    }

    ad_proc -public change_event_handler {
        community_id
        event
        old_value
        new_value
    } { 
        listens for the following events: 
    } { 
    }   

}
