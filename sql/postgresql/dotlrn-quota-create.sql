--
-- Copyright (C) 2004 University of Valencia
--
--  This file is part of dotLRN.
--
--  dotLRN is free software; you can redistribute it and/or modify it under the
--  terms of the GNU General Public License as published by the Free Software
--  Foundation; either version 2 of the License, or (at your option) any later
--  version.
--
--  dotLRN is distributed in the hope that it will be useful, but WITHOUT ANY
--  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
--  FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
--  details.
--
--
--   Procedures to support the dotlrn quota
--
--   @author Agustin Lopez (Agustin.Lopez@uv.es)
--   @creation-date 2004-10-10
--   @version $Id: dotlrn-quota-create.sql,v 0.1 2004/10/10

-- create the implementation
select acs_sc_impl__new (
                'dotlrn_applet',
                'dotlrn_quota',
                'dotlrn_quota'
);

-- add all the hooks

-- GetPrettyName
select acs_sc_impl_alias__new (
               'dotlrn_applet',
               'dotlrn_quota',
               'GetPrettyName',
               'dotlrn_quota::get_pretty_name',
               'TCL'
);

-- AddApplet
select acs_sc_impl_alias__new (
               'dotlrn_applet',
               'dotlrn_quota',
               'AddApplet',
               'dotlrn_quota::add_applet',
               'TCL'
);

-- RemoveApplet
select acs_sc_impl_alias__new (
               'dotlrn_applet',
               'dotlrn_quota',
               'RemoveApplet',
               'dotlrn_quota::remove_applet',
               'TCL'
);

-- AddAppletToCommunity
select acs_sc_impl_alias__new (
               'dotlrn_applet',
               'dotlrn_quota',
               'AddAppletToCommunity',
               'dotlrn_quota::add_applet_to_community',
               'TCL'
);

-- RemoveAppletFromCommunity
select acs_sc_impl_alias__new (
               'dotlrn_applet',
               'dotlrn_quota',
               'RemoveAppletFromCommunity',
               'dotlrn_quota::remove_applet_from_community',
               'TCL'
);

-- AddUser
select acs_sc_impl_alias__new (
               'dotlrn_applet',
               'dotlrn_quota',
               'AddUser',
               'dotlrn_quota::add_user',
               'TCL'
);

-- RemoveUser
select acs_sc_impl_alias__new (
               'dotlrn_applet',
               'dotlrn_quota',
               'RemoveUser',
               'dotlrn_quota::remove_user',
               'TCL'
);

-- AddUserToCommunity
select acs_sc_impl_alias__new (
               'dotlrn_applet',
               'dotlrn_quota',
               'AddUserToCommunity',
               'dotlrn_quota::add_user_to_community',
               'TCL'
);

-- RemoveUserFromCommunity
select acs_sc_impl_alias__new (
               'dotlrn_applet',
               'dotlrn_quota',
               'RemoveUserFromCommunity',
               'dotlrn_quota::remove_user_from_community',
               'TCL'
);

-- AddPortlet
select acs_sc_impl_alias__new (
        'dotlrn_applet',
        'dotlrn_quota',
        'AddPortlet',
        'dotlrn_quota::add_portlet',
        'TCL'
    );

-- RemovePortlet
select acs_sc_impl_alias__new (
        'dotlrn_applet',
        'dotlrn_quota',
        'RemovePortlet',
        'dotlrn_quota::remove_portlet',
        'TCL'
);

-- Clone
select acs_sc_impl_alias__new (
        'dotlrn_applet',
        'dotlrn_quota',
        'Clone',
        'dotlrn_quota::clone',
        'TCL'
);

select acs_sc_impl_alias__new (
        'dotlrn_applet',
        'dotlrn_quota',
        'ChangeEventHandler',
        'dotlrn_quota::change_event_handler',
        'TCL'
);

-- Add the binding
select acs_sc_binding__new (
            'dotlrn_applet',
            'dotlrn_quota'
);
