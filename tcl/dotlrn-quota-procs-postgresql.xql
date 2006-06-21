<?xml version="1.0"?>

<queryset>
<rdbms><type>postgresql</type><version>7.1</version></rdbms>

<fullquery name="dotlrn_quota::clone.call_quota_clone">
  <querytext>
    select quota__clone ( 
        :old_package_id,
        :new_package_id
      );
  </querytext>
</fullquery>


</queryset>
