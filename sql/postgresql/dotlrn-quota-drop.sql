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
--   @version $Id: dotlrn-quota-drop.sql,v 0.1 2004/10/10

select acs_sc_impl__delete(
           'dotlrn_applet',             -- impl_contract_name
           'dotlrn_quota'                -- impl_name
);


-- add all the hooks

-- GetPrettyName
select acs_sc_impl_alias__delete (
               'dotlrn_applet',
               'dotlrn_quota',
               'GetPrettyName'
);

-- AddApplet
select acs_sc_impl_alias__delete (
               'dotlrn_applet',
               'dotlrn_quota',
               'AddApplet'
);

-- RemoveApplet
select acs_sc_impl_alias__delete (
               'dotlrn_applet',
               'dotlrn_quota',
               'RemoveApplet'
);

-- AddAppletToCommunity
select acs_sc_impl_alias__delete (
               'dotlrn_applet',
               'dotlrn_quota',
               'AddAppletToCommunity'
);

-- RemoveAppletFromCommunity
select acs_sc_impl_alias__delete (
               'dotlrn_applet',
               'dotlrn_quota',
               'RemoveAppletFromCommunity'
);

-- AddUser
select acs_sc_impl_alias__delete (
               'dotlrn_applet',
               'dotlrn_quota',
               'AddUser'
);

-- RemoveUser
select acs_sc_impl_alias__delete (
               'dotlrn_applet',
               'dotlrn_quota',
               'RemoveUser'
);

-- AddUserToCommunity
select acs_sc_impl_alias__delete (
               'dotlrn_applet',
               'dotlrn_quota',
               'AddUserToCommunity'
);

-- RemoveUserFromCommunity
select acs_sc_impl_alias__delete (
               'dotlrn_applet',
               'dotlrn_quota',
               'RemoveUserFromCommunity'
);

-- AddPortlet
select acs_sc_impl_alias__delete (
        'dotlrn_applet',
        'dotlrn_quota',
        'AddPortlet'
    );

-- RemovePortlet
select acs_sc_impl_alias__delete (
        'dotlrn_applet',
        'dotlrn_quota',
        'RemovePortlet'
);

-- Clone
select acs_sc_impl_alias__delete (
        'dotlrn_applet',
        'dotlrn_quota',
        'Clone'
);


-- Add the binding
select acs_sc_binding__delete (
            'dotlrn_applet',
            'dotlrn_quota'
);
