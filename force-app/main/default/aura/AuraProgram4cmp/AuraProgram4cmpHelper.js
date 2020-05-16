({
    fetchObject : function(component,event,helper)
    {
        //method to fetch objects
        try
        {
            var call_Apex_Method = component.get("c.fetchSobject");
            call_Apex_Method.setCallback(this,function(response)
            {
                var state = response.getState();
                if(state == 'SUCCESS')
                {
                    console.log('in success');
                    var serverResponse = response.getReturnValue();
                    component.set("v.sObjectList",serverResponse);

                }
                else
                {
                    alert('unable get sobject list');
                }
            });
            $A.enqueueAction(call_Apex_Method);
        }
        catch(ex)
        {
            console.log(ex.message);
        }

    },
    loadFields : function(component,event,helper)
    {
        // alert(event.getParam('value'));
        var objectName = event.getParam('value');
        console.log('objectName in load fields helper---> '+objectName);
        var action = component.get("c.getAllFieldsName");
        action.setParams({
            "objname" : objectName
        });

        action.setCallback(this, function(response) {
            var state = response.getState();
            var options = [] ;
            var serverResponse = response.getReturnValue();
            if (state === "SUCCESS") {
                //alert("From server: " + response.getReturnValue());
                component.set("v.fieldList",serverResponse);
                for(var i=0;i<=serverResponse.length;i++)
                {
                    var temp = { value: serverResponse[i], label: serverResponse[i] };
                    options.push(temp);
                    if(i == 0)
                    {
                        component.set("v.requiredOptions",serverResponse[i]);
                    }
                }
                // console.log(options);
                //console.log('======'+JSON.stringify(options));

                //setting value to attribute
                component.set("v.optionList",options);
                component.set("v.optionValue",options);

            }
            else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " +
                            errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }
        });
        $A.enqueueAction(action);
    },
    getDataType : function(component,event,helper)
    {
        //method to get data type of seelcted field
        var selected_ObjectName = component.get("v.selectedObjectName");
        var selected_FieldName = component.get("v.selectedFilterField");
        console.log(' getdatatype () --> helper before call apex --> object '+selected_ObjectName +' field '+selected_FieldName);

        if(selected_FieldName == null || selected_FieldName == '')
        {
            console.log('Null field Name recieved');
        }
        else
        {
            var action = component.get("c.getDataType_Apex");
            action.setParams({
                "objname" : selected_ObjectName,
                "fieldName" : selected_FieldName
            });
            action.setCallback(this, function(response)
            {
                var state = response.getState();
                var serverResponse = response.getReturnValue();
                if (state === "SUCCESS")
                {

                    console.log(' getdatatype () --> server res --> '+serverResponse +' and requested field is '+selected_FieldName);
                    component.set("v.APIAttrib",selected_FieldName);
                    component.set("v.APIAttribDataType",serverResponse);
                    var dataType = component.get("v.APIAttribDataType");
                    var apiName = component.get("v.APIAttrib");

                    //alert('get filter field method --> Api Name --> '+apiName+'Data Type --> '+dataType);
                    //
                    //filling the symbol attribute
                    if(dataType == null || dataType == 'null' || dataType == 'undefined')
                    {
                        component.set("v.symbolsFirst",null);
                    }
                    else if(dataType == 'PICKLIST' || dataType == 'picklist')
                    {
                        var symbols = [
                            { value: "=", label: "=" },
                            { value: "!=", label: "!=" },
                            { value: "LIKE1", label: "Start With"},
                            { value: "LIKE2", label:"End With"},
                            { value: "LIKE3",label:"Contains"},
                            { value: "IN", label: "IN" },
                            { value: "NOT IN", label: "NOT IN" }];
                        //setting appropriate symbol
                        component.set("v.symbolsFirst",symbols);
                        component.set("v.showInputBox",'true');
                        component.set("v.showComboBox",'false');
                        component.set("v.showDateInpBox",'false');
                        component.set("v.showDateTimeInpBox",'false');

                    }
                    else if(dataType == 'TEXTAREA' || dataType == 'textarea')
                    {
                        var symbols = [{ value: "", label: "Unable to Filter" }];
                        component.set("v.symbolsFirst",symbols);
                        component.set("v.showInputBox",'true');
                        component.set("v.showComboBox",'false');
                        component.set("v.showDateInpBox",'false');
                        component.set("v.showDateTimeInpBox",'false');
                    }
                    else if(dataType == 'CURRENCY' || dataType == 'currency')
                    {
                        var symbols = [
                            { value: "=", label: "=" },
                            { value: "!=", label: "!=" },
                            { value: "<", label: "<" },
                            { value: "<=", label: "<=" },
                            { value: ">", label: ">" },
                            { value: ">=", label: ">=" },
                            { value: "IN", label: "IN" },
                            { value: "NOT IN", label: "NOT IN" }];
                        component.set("v.symbolsFirst",symbols);
                        component.set("v.showInputBox",'true');
                        component.set("v.showComboBox",'false');
                        component.set("v.showDateInpBox",'false');
                        component.set("v.showDateTimeInpBox",'false');
                    }
                    else if(dataType == 'DOUBLE' || dataType == 'double' || dataType =='INTEGER' || dataType =='integer')
                    {
                        var symbols = [
                            { value: "=", label: "=" },
                            { value: "!=", label: "!=" },
                            { value: "<", label: "<" },
                            { value: "<=", label: "<=" },
                            { value: ">", label: ">" },
                            { value: ">=", label: ">=" }];
                        component.set("v.symbolsFirst",symbols);
                        component.set("v.showInputBox",'true');
                        component.set("v.showComboBox",'false');
                        component.set("v.showDateInpBox",'false');
                        component.set("v.showDateTimeInpBox",'false');
                    }
                    else if(dataType == 'BOOLEAN' || dataType == 'boolean' )
                    {
                        var symbols = [
                            { value: "=", label: "=" },
                            { value: "!=", label: "!=" }];
                        component.set("v.symbolsFirst",symbols);
                        component.set("v.showInputBox",'true');
                        component.set("v.showComboBox",'false');
                        component.set("v.showDateInpBox",'false');
                        component.set("v.showDateTimeInpBox",'false');
                    }
                    else if( dataType == 'ID'|| dataType == 'id')
                    {
                        var symbols = [
                            { value: "=", label: "=" },
                            { value: "!=", label: "!=" }];
                        component.set("v.symbolsFirst",symbols);
                        component.set("v.showInputBox",'true');
                        component.set("v.showComboBox",'false');
                        component.set("v.showDateInpBox",'false');
                        component.set("v.showDateTimeInpBox",'false');
                    }

                    else if(dataType == 'REFERENCE' || dataType == 'reference')
                    {
                        var symbols = [
                            { value: "=", label: "=" },
                            { value: "!=", label: "!=" }];
                        component.set("v.symbolsFirst",symbols);
                        component.set("v.showInputBox",'false');
                        component.set("v.showComboBox",'true');
                        component.set("v.showDateInpBox",'false');
                        component.set("v.showDateTimeInpBox",'false');

                    }
                    else if( dataType == 'DATETIME' || dataType == 'datetime' || dataType == 'dateTime' || dataType == 'DateTime' )
                    {
                        var symbols = [
                            { value: "=", label: "=" },
                            { value: "!=", label: "!=" },
                            { value: "<", label: "<" },
                            { value: "<=", label: "<=" },
                            { value: ">", label: ">" },
                            { value: ">=", label: ">=" }];
                        component.set("v.symbolsFirst",symbols);
                        component.set("v.showInputBox",'false');
                        component.set("v.showComboBox",'false');
                        component.set("v.showDateInpBox",'false');
                        component.set("v.showDateTimeInpBox",'true');
                    }
                    else if(dataType == 'DATE' || dataType == 'date')
                    {
                        var symbols = [
                            { value: "=", label: "=" },
                            { value: "!=", label: "!=" },
                            { value: "<", label: "<" },
                            { value: "<=", label: "<=" },
                            { value: ">", label: ">" },
                            { value: ">=", label: ">=" }];
                        component.set("v.symbolsFirst",symbols);
                        component.set("v.showInputBox",'false');
                        component.set("v.showComboBox",'false');
                        component.set("v.showDateInpBox",'true');
                        component.set("v.showDateTimeInpBox",'false');
                    }
                    else if(dataType == 'URL' || dataType == 'url')
                    {
                        var symbols = [
                            { value: "=", label: "=" },
                            { value: "!=", label: "!=" },
                            { value: "LIKE1", label: "Start With"},
                            { value: "LIKE2", label:"End With"},
                            { value: "LIKE3",label:"Contains"}
                        ];
                        component.set("v.symbolsFirst",symbols);
                        component.set("v.showInputBox",'true');
                        component.set("v.showComboBox",'false');
                        component.set("v.showDateInpBox",'false');
                        component.set("v.showDateTimeInpBox",'false');
                    }
                    else if(dataType == 'PHONE' || dataType == 'phone')
                    {
                        var symbols = [
                            { value: "=", label: "=" },
                            { value: "!=", label: "!=" },
                            { value: "LIKE1", label: "Start With"},
                            { value: "LIKE2", label:"End With"},
                            { value: "LIKE3",label:"Contains"}
                        ];
                        component.set("v.symbolsFirst",symbols);
                        component.set("v.showInputBox",'true');
                        component.set("v.showComboBox",'false');
                        component.set("v.showDateInpBox",'false');
                        component.set("v.showDateTimeInpBox",'false');
                    }
                    else if(dataType == 'STRING' || dataType == 'string')
                    {
                        var symbols = [
                            { value: "=", label: "=" },
                            { value: "!=", label: "!=" },
                            { value: "LIKE1", label: "Start With"},
                            { value: "LIKE2", label:"End With"},
                            { value: "LIKE3",label:"Contains"}
                        ];
                        component.set("v.symbolsFirst",symbols);
                        component.set("v.showInputBox",'true');
                        component.set("v.showComboBox",'false');
                        component.set("v.showDateInpBox",'false');
                        component.set("v.showDateTimeInpBox",'false');

                    }
                    else if(dataType == 'ADDRESS' || dataType == 'address')
                    {
                        var symbols = [
                            {value: "Use Distance expressions" ,label: "Use Distance expressions"}
                        ];

                        component.set("v.symbolsFirst",symbols);
                        component.set("v.showInputBox",'true');
                        component.set("v.showComboBox",'false');
                        component.set("v.showDateInpBox",'false');
                        component.set("v.showDateTimeInpBox",'false');
                    }
                    else if(dataType == 'MULTIPICKLIST' || dataType == 'multipicklist')
                    {
                        var symbols = [
                            { value: "INCLUDES", label: "INCLUDES" },
                            { value: "EXCLUDES", label: "EXCLUDES" }];
                        component.set("v.symbolsFirst",symbols);
                        component.set("v.showInputBox",'true');
                        component.set("v.showComboBox",'false');
                        component.set("v.showDateInpBox",'false');
                        component.set("v.showDateTimeInpBox",'false');
                    }

                }
                else if (state === "ERROR") {
                    var errors = response.getError();
                    if (errors) {
                        if (errors[0] && errors[0].message) {
                            console.log("Error message: " + errors[0].message);
                        }
                    } else {
                        console.log("Unknown error");
                    }
                }
            });
            $A.enqueueAction(action);
        }
    },
    fetchDataByQuery : function(component,event,helper)
    {
        //method to get Selected value from dual select list
        var selectedOptionsList = event.getParam("value");


        //adding text to make query
        var addData= 'SELECT '+selectedOptionsList+' FROM '+component.get("v.selectedObjectName");
        // displaying query box with created query 
        component.set("v.showQueryBox",true);
        component.set("v.query",addData);

        var header =[];
        for(var i=0;i<selectedOptionsList.length;i++)
        {
            var temp = {label:selectedOptionsList[i],fieldName:selectedOptionsList[i]};
            header.push(temp);
        }

        console.log('====================> header data ----------> '+JSON.stringify(header));
        component.set("v.tableHeader",header);

        if(addData === '' || addData == null || addData === 'undefined')
        {
            console.log('Null querey recieved');
            return null;
        }
        else
        {
            //console.log('else blok of fetchDataByQuery');
            //console.log(' ---------> recieved from UI data  '+xx);

            var call_Apex_Method = component.get("c.getDataByQuery_Apex");
            call_Apex_Method.setParams({
                "rec_Query" : addData
            });
            call_Apex_Method.setCallback(this,function(response)
            {
                var state = response.getState();
                console.log('state value ----> '+addData);
                console.log('response ---> '+response.getReturnValue());
                if(state === 'SUCCESS' & component.isValid())
                {
                    var serverResponse = response.getReturnValue();
                    component.set("v.showResponseTable",true);
                    component.set("v.rec_Query_Response",serverResponse);
                    var ss = component.get("v.rec_Query_Response");
                    console.log('server response -------ssssss-----> '+JSON.stringify(ss));
                    //console.log(JSON.stringify(serverResponse));
                }


            });
            $A.enqueueAction(call_Apex_Method);
        }


    },
    getFilterFieldFistHelp : function(component,event,helper)//method to get api name and type of selected field in filter first to populate symbol picklist
    {
        var selectedField = event.getParam('value');
        var selectedObject = component.get("v.selectedObjectName");
        console.log('getFilterFieldFirstHelper -----> ');
        console.log('selected field --> '+selectedField);
        console.log('selected Object ---> '+selectedObject);
        //alert('get filter field method --> Object --> '+selectedObject+' Field Name ---> '+selectedField ); 
        helper.getDataType(component,event,helper);

    },
    applyFilterButtonHelper : function(component,event,helper)
    {
        var dataType = component.get("v.APIAttribDataType");
        // alert('filter data type --> '+dataType);
        if(dataType == 'REFERENCE' || dataType == 'reference' )
        {
            //filter setion
            var selectedField = component.get("v.selectedFilterField");
            var selectedSysmbol = component.get("v.symbolFilterFirst");
            var selectedObjectName = component.get("v.selectedObjectName");
            alert('get data  button helper for reference field '+selectedField+'      '+selectedSysmbol+'     '+selectedObjectName);

        }
        else if(dataType == 'DATE' || dataType == 'date')
        {
            var selectedField = component.get("v.selectedFilterField");
            var selectedSysmbol = component.get("v.symbolFilterFirst");
            var matchingKey = component.find("filterByDate").get("v.value");
            var dataType = component.get("v.APIAttribDataType");
            var selectedObjectName = component.get("v.selectedObjectName");
            //alert("applyFilterButtonHelper() selectedField -> "+selectedField+' object name -> '+selectedObjectName+' selectedSysmbol -> '+selectedSysmbol+' matchingKey -> '+matchingKey+' data type -> '+dataType);

            //previously queried fields
            var dualListSelectedField  = component.get("v.tableHeader");
            var prevFields =[];
            for(var i=0;i<dualListSelectedField.length;i++)
            {
                var temp = dualListSelectedField[i].fieldName;
                prevFields.push(temp);
            }
            //alert (prevFields);
            //alert(JSON.stringify(dualListSelectedField));+' WHERE '+selectedField+' '+selectedSysmbol+' \''+matchingKey+'\'';

            /* creating new query for applying filter*/
            var reQuery = 'SELECT '+prevFields+' FROM '+selectedObjectName+' ';
            if(matchingKey != null || matchingKey != 'null' || matchingKey.isEmpty() || matchingKey != '')
            {

                if(selectedSysmbol === 'LIKE1')
                {
                    matchingKey = matchingKey+'%';
                    var addLikeFilter = ' WHERE '+selectedField+' LIKE '+' \''+matchingKey+'\'';
                    reQuery = reQuery.concat(addLikeFilter);
                }
                else if(selectedSysmbol === 'LIKE2')
                {
                    matchingKey = '%'+matchingKey;
                    var addLikeFilter = ' WHERE '+selectedField+' LIKE '+'\''+matchingKey+'\'';
                    reQuery = reQuery.concat(addLikeFilter);
                }
                else if(selectedSysmbol === 'LIKE3')
                {
                    matchingKey = '%'+matchingKey+'%';
                    var addLikeFilter = ' WHERE '+selectedField+' LIKE'+'\''+matchingKey+'\'';
                    reQuery = reQuery.concat(addLikeFilter);
                }
                else if(selectedSysmbol === 'INCLUDES')
                {
                    var matchingKey = '(\''+matchingKey+'\')';
                    var addIncludeFilter = 'WHERE '+selectedField+' INCLUDES '+matchingKey;
                    reQuery = reQuery.concat(addIncludeFilter);
                }
                else if(selectedSysmbol === 'EXCLUDES')
                {
                    var matchingKey = '(\''+matchingKey+'\')';
                    var addIncludeFilter = 'WHERE '+selectedField+' EXCLUDES '+matchingKey;
                    reQuery = reQuery.concat(addIncludeFilter);
                }
                else if(selectedSysmbol === 'IN')
                {
                    var matchingKey = '(\''+matchingKey+'\')';
                    var addIncludeFilter = 'WHERE '+selectedField+' IN '+matchingKey;
                    reQuery = reQuery.concat(addIncludeFilter);
                }
                else if(selectedSysmbol === 'NOT IN')
                {
                    var matchingKey = '(\''+matchingKey+'\')';
                    var addIncludeFilter = 'WHERE '+selectedField+'NOT IN '+matchingKey;
                    reQuery = reQuery.concat(addIncludeFilter);
                }
                else if(selectedSysmbol === '=' || selectedSysmbol === '!=' || selectedSysmbol === '<' || selectedSysmbol === '>' || selectedSysmbol === '<='|| selectedSysmbol === '>=')
                {
                    matchingKey = '\''+matchingKey+'\'';
                    var addLikeFilter = ' WHERE '+selectedField+' '+selectedSysmbol+' '+matchingKey;
                    reQuery = reQuery.concat(addLikeFilter);
                }
            }


            component.set("v.query",reQuery);

            /*calling apex method for filtered data*/

            if(reQuery == '' || reQuery == null || reQuery == 'undefined')
            {
                console.log('Null querey recieved');
                return null;
            }
            else
            {
                //console.log('else blok of fetchDataByQuery');
                //console.log(' ---------> recieved from UI data  '+xx);

                var call_Apex_Method = component.get("c.getDataByQuery_Apex");
                call_Apex_Method.setParams({
                    "rec_Query" : reQuery
                });
                call_Apex_Method.setCallback(this,function(response)
                {
                    var state = response.getState();
                    console.log('state value ----> '+reQuery);
                    console.log('response ---> '+response.getReturnValue());
                    if(state === 'SUCCESS' & component.isValid())
                    {
                        var serverResponse = response.getReturnValue();
                        component.set("v.showResponseTable",true);
                        component.set("v.rec_Query_Response",serverResponse);
                        var ss = component.get("v.rec_Query_Response");
                        console.log('server response -------ssssss-----> '+JSON.stringify(ss));
                        //console.log(JSON.stringify(serverResponse));
                    }


                });
                $A.enqueueAction(call_Apex_Method);
            }
        }

    },
    //combobox 
    getComboBoxRelatedList : function(component,event,helper)
    {

        //filter setion
        var selectedField = component.get("v.selectedFilterField");
        var dataType = component.get("v.APIAttribDataType");
        var selectedObjectName = component.get("v.selectedObjectName");
        //alert('hi helper selected field --> '+selectedField+'  data  type --->'+dataType+' Selected object Name ---> '+selectedObjectName);

        var call_Apex = component.get("c.getObjectByFieldName_Apex");
        call_Apex.setParams({"objName":selectedObjectName,"fieldName":selectedField});

        call_Apex.setCallback(this,function(response){
            var state = response.getState();
            console.log('state--->'+state);
            var serValue = response.getReturnValue();
            console.log('response server ----> '+serValue);
            component.set("v.comboBoxOption",serValue);

        });
        $A.enqueueAction(call_Apex);

    }
})