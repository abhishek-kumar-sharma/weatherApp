<aura:application description="CalenderDemoApp" extends="force:slds">
    <aura:dependency resource="c:CalenderDemoCmp" />
    <!--<c:CalenderDemoCmp />-->
<lightning:tabset selectedTabId="A" variant="default">
<lightning:tab label="Calender Tab" id="A" title="Calender Tab" class="tabWidth" >
<div>
    <c:CalenderDemoCmp />
</div>
</lightning:tab>
    <lightning:tab title="Custom LookUp Example" id="B" label="Custom Lookup" class="tabWidth">
    <div class="slds-text-color--error slds-align_absolute-center">
        <B >Under Development</B>
    </div>
    </lightning:tab>
</lightning:tabset>
</aura:application>