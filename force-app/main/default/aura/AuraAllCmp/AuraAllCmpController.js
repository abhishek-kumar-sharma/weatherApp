({
    clearHandler : function(component, event, helper) 
    {
        component.set("v.Program1Button",false)	
        component.set("v.Program2Button",false)
        component.set("v.Program3Button",false)
        component.set("v.Program4Button",false)
        component.set("v.Program7Button",false)
        component.set("v.Program8Button",false)
        component.set("v.Program9Button",false)
        component.set("v.Program10Button",false)
        component.set("v.Program2ReTryButton",false)
    },  
    button1Handler : function(component, event, helper) 
    {  
        component.set("v.Program1Button",true)	
        component.set("v.Program2Button",false)
        component.set("v.Program3Button",false)
        component.set("v.Program4Button",false)
        component.set("v.Program7Button",false)
        component.set("v.Program8Button",false)
        component.set("v.Program9Button",false)
        component.set("v.Program10Button",false)
        component.set("v.Program2ReTryButton",false)
    },
    button2Handler : function(component,event,helper)
    {
        component.set("v.Program1Button",false)
        component.set("v.Program7Button",false)
        component.set("v.Program2Button",true)
        component.set("v.Program3Button",false)
        component.set("v.Program4Button",false)
        component.set("v.Program8Button",false)
        component.set("v.Program9Button",false)
        component.set("v.Program10Button",false)
        component.set("v.Program2ReTryButton",false)
    },
    button3Handler : function(component,event,helper)
    {
        component.set("v.Program1Button",false)
        component.set("v.Program7Button",false)
        component.set("v.Program2Button",false) 
        component.set("v.Program3Button",true) 
        component.set("v.Program4Button",false)
        component.set("v.Program8Button",false)
        component.set("v.Program9Button",false)
        component.set("v.Program10Button",false)
        component.set("v.Program2ReTryButton",false)
        
    },
    button4Handler : function(component,event,helper)
    {
        component.set("v.Program1Button",false)
        component.set("v.Program7Button",false)
        component.set("v.Program2Button",false) 
        component.set("v.Program3Button",false) 
        component.set("v.Program8Button",false)
        component.set("v.Program9Button",false)
        component.set("v.Program4Button",true)
        component.set("v.Program10Button",false)
        component.set("v.Program2ReTryButton",false)
        
    },
    button7Handler : function(component,event,helper)
    {
        component.set("v.Program1Button",false)
        component.set("v.Program2Button",false)
        component.set("v.Program3Button",false)
        component.set("v.Program4Button",false)
        component.set("v.Program7Button",true)
        component.set("v.Program8Button",false)
        component.set("v.Program9Button",false)
        component.set("v.Program10Button",false)
        component.set("v.Program2ReTryButton",false)
    },
    button8Handler : function(component,event,helper)
    {
        component.set("v.Program1Button",false)
        component.set("v.Program2Button",false)
        component.set("v.Program3Button",false)
        component.set("v.Program4Button",false)
        component.set("v.Program7Button",false)
        component.set("v.Program8Button",true)
        component.set("v.Program9Button",false)
        component.set("v.Program10Button",false)
        component.set("v.Program2ReTryButton",false)
    },
    button9Handler : function(component,event,helper)
    {
        component.set("v.Program1Button",false)
        component.set("v.Program2Button",false)
        component.set("v.Program3Button",false)
        component.set("v.Program4Button",false)
        component.set("v.Program7Button",false)
        component.set("v.Program8Button",false)
        component.set("v.Program9Button",true)
        component.set("v.Program10Button",false)
        component.set("v.Program2ReTryButton",false)
        
    },
    button10Handler : function(component,event,helper)
    {
        component.set("v.Program1Button",false)
        component.set("v.Program2Button",false)
        component.set("v.Program3Button",false)
        component.set("v.Program4Button",false)
        component.set("v.Program7Button",false)
        component.set("v.Program8Button",false)
        component.set("v.Program9Button",false)
        component.set("v.Program10Button",true)
        component.set("v.Program2ReTryButton",false)
    },
    Program2ReTryButtonHandler : function (component,event,helper)
    {
        component.set("v.Program1Button",false)
        component.set("v.Program2Button",false)
        component.set("v.Program3Button",false)
        component.set("v.Program4Button",false)
        component.set("v.Program7Button",false)
        component.set("v.Program8Button",false)
        component.set("v.Program9Button",false)
        component.set("v.Program10Button",false)
        component.set("v.Program2ReTryButton",true)

    }
})