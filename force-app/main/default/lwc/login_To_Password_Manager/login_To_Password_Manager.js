/* eslint no-console:["error",{allow:["warn","error","log"]}] */
import { LightningElement, track } from "lwc";
import loginData from "@salesforce/apex/Login_To_Password_Manager_Controller.validateUser_Apex";
import loginDetailData from "@salesforce/apex/Login_To_Password_Manager_Controller.getLoginDetails";
import deleteRecord from "@salesforce/apex/Login_To_Password_Manager_Controller.deleteSelectedRecord";
import updateLoginRecord from "@salesforce/apex/Login_To_Password_Manager_Controller.updateLoginDetails";
export default class Login_To_Password_Manager extends LightningElement {
  /**
   * Variable section to hold all the condition and intermediate value
   * Created by Abhishek
   */
  @track user = {
    username: undefined,
    password: undefined
  };
  @track isLogin = false;
  @track showToast = false;
  @track hasPageError = "slds-hide";
  @track errorMessage = null;
  @track allloginRecords = null;
  @track dataTableColumns = [];
  @track dataTableDataLoadWait = false;
  @track isviewDetails = false;
  @track selectedRecordFromDataTable = null;
  @track isDisabled = false;
  @track modelFooterClass = "slds-modal__footer";
  @track toastMessage = null;
  @track searchFilter = null;
  @track toastThemeClass = "slds-notify slds-notify_toast slds-theme_success";

  /**  */
  connectedCallback() {
    if (sessionStorage.getItem("loginId")) {
      this.hasPageError = "slds-hide";
      this.errorMessage = null;
      this.isLogin = true;
      this.dataTableDataLoadWait = true;
      this.getDataFromApex();
      this.googleTranslateElementInit();
    }
  }

  /**
   *  Handle login button action
   *  Method to check the user record and create session if record exist
   * Created By : Abhishek Kumar Sharma
   * Created Date : 22-MAy-2019
   */
  handleLogin() {
    try {
      loginData({
        username: this.user.username,
        password: this.user.password
      })
        .then(value => {
          if (value !== undefined && value !== null) {
            this.hasPageError = "slds-hide";
            this.errorMessage = null;
            this.isLogin = true;
            sessionStorage.setItem("loginId", value);
            this.dataTableDataLoadWait = true;
            this.getDataFromApex();
          } else {
            this.hasPageError =
              "slds-notify slds-notify_alert slds-theme_alert-texture slds-theme_error sdls-m-bottom_small";
            this.errorMessage = "No Such user found";
          }
        })
        .catch(error => {
          this.hasPageError =
            "slds-notify slds-notify_alert slds-theme_alert-texture slds-theme_error sdls-m-bottom_small";
          this.errorMessage = error.body.message;
          console.error("Error ", error.body.message);
        });
    } catch (exception) {
      this.hasPageError =
        "slds-notify slds-notify_alert slds-theme_alert-texture slds-theme_error sdls-m-bottom_small";
      this.errorMessage = exception.message;
      console.error(
        "Exception occuured while login. \n Message ::" + exception.message
      );
    }
  }

  /**
   * Method to handle the logout button action
   * This method will invalidate the active session of user
   * Created By : Abhishek Kumar Sharma
   * Created Date : 22-May-2019
   */
  handleLogout() {
    this.hasPageError = "slds-hide";
    this.errorMessage = null;
    this.isLogin = false;
    this.user = {};
    sessionStorage.clear();
  }

  /**
   * Handler method to set the input value , name must be same as UI
   * Created By : Abhishek Kumar Sharma
   * Created date : 23-May-2019
   */
  setInputValue(event) {
    if (
      event.target.value !== null &&
      event.target.value !== undefined &&
      event.target.value.trim() !== ""
    ) {
      this.user[event.target.name] = event.target.value;
    }
  }

  /**
   * Handler method to set the input value , name must be same as UI
   * Created By : Abhishek Kumar Sharma
   * Created date : 23-May-2019
   */
  setInputForPopUpEditMode(event) {
    if (
      event.target.value !== null &&
      event.target.value !== undefined &&
      event.target.value.trim() !== "" &&
      event.target.type !== "checkbox"
    ) {
      this.selectedRecordFromDataTable[event.target.name] = event.target.value;
    } else if (
      event.target.checked !== null &&
      event.target.checked !== undefined &&
      event.target.type === "checkbox"
    ) {
      this.selectedRecordFromDataTable[event.target.name] =
        event.target.checked;
    }
  }

  /**
   * Method to get all the data from apex after login
   * Created By : Abhishek Kumar Sharma
   * Created date : 23-May-2019
   */
  getDataFromApex() {
    try {
      if (
        sessionStorage.getItem("loginId") !== null &&
        sessionStorage.getItem("loginId") !== undefined
      ) {
        loginDetailData({
          userId: sessionStorage.getItem("loginId")
        })
          .then(value => {
            if (value !== null && value !== undefined) {
              this.hasPageError = "slds-hide";
              this.errorMessage = null;
              console.log("hello value ==>", value);
              this.loadDataTable(value);
            } else {
              this.isLogin = false;
              this.hasPageError =
                "slds-notify slds-notify_alert slds-theme_alert-texture slds-theme_error sdls-m-bottom_small";
              this.errorMessage =
                "Unable to get your data right now. Please logout and try again";
            }
          })
          .catch(error => {
            this.isLogin = false;
            this.hasPageError =
              "slds-notify slds-notify_alert slds-theme_alert-texture slds-theme_error sdls-m-bottom_small";
            this.errorMessage = error.body.message;
            console.error(
              "Exception occured while setting the call back. \n Message ::" +
                error.body.message
            );
          });
      }
    } catch (exception) {
      console.error(
        "Exception occurred. Please contact System administrator for help.\n Message ::" +
          exception.message
      );
    }
  }

  /**
   * Method to get all the data from apex after login
   * Created By : Abhishek Kumar Sharma
   * Created date : 23-May-2019
   */
  loadDataTable(userLoginDetails) {
    if (userLoginDetails !== null && userLoginDetails !== undefined) {
      userLoginDetails.forEach(element => {
        if (element.ECSV__isValidated__c !== true) {
          element.addClass = "redColor";
        }
      });
      console.log("userLoginDetails ==>", userLoginDetails);
      let dataTableAction = [
        { label: "View", name: "view", iconName: "action:preview" },
        { label: "Edit", name: "edit", iconName: "action:edit" },
        { label: "Delete", name: "delete", iconName: "action:delete" },
        { label: "Validate", name: "validate", iconName: "utility:sync" },
        { label: "Download", name: "download", iconName: "utility:download" },
        { label: "Login", name: "login", iconName: "utility:new_window" }
      ];
      this.dataTableColumns = [
        {
          label: "Project Name",
          fieldName: "ECSV__Project_Name__c",
          type: "text",
          cellAttributes: {
            class: {
              fieldName: "addClass"
            }
          }
        },
        {
          label: "Org Name",
          fieldName: "ECSV__Organization_Name__c",
          type: "text",
          cellAttributes: {
            class: {
              fieldName: "addClass"
            }
          }
        },
        {
          label: "User Name",
          fieldName: "ECSV__User_Name__c",
          type: "text",
          cellAttributes: {
            class: {
              fieldName: "addClass"
            }
          }
        },
        {
          label: "Password",
          fieldName: "ECSV__Password__c",
          type: "text",
          cellAttributes: {
            class: {
              fieldName: "addClass"
            }
          }
        },
        {
          label: "Security Token",
          fieldName: "ECSV__Security_Token__c",
          type: "text",
          cellAttributes: {
            class: {
              fieldName: "addClass"
            }
          }
        },
        {
          label: "Is Sandbox",
          fieldName: "ECSV__isSandbox__c",
          type: "boolean",
          cellAttributes: {
            class: {
              fieldName: "addClass"
            }
          }
        },
        {
          label: "Is Salesfore Credentials",
          fieldName: "ECSV__is_Salesforce_Credentials__c",
          type: "boolean",
          cellAttributes: {
            class: {
              fieldName: "addClass"
            }
          }
        },
        {
          label: "Is Valid",
          fieldName: "ECSV__isValidated__c",
          type: "boolean",
          cellAttributes: {
            class: {
              fieldName: "addClass"
            }
          }
        },
        {
          label: "Validated On",
          fieldName: "ECSV__Validated_On__c",
          type: "date",
          cellAttributes: {
            class: {
              fieldName: "addClass"
            }
          }
        },
        {
          label: "Action",
          type: "action",
          typeAttributes: { rowActions: dataTableAction }
        }
      ];
      this.dataTableDataLoadWait = false;
      this.allloginRecords = userLoginDetails;
      console.log(userLoginDetails);
    }
  }

  /**
   * Method to get all the data from apex after login
   * Created By : Abhishek Kumar Sharma
   * Created date : 23-May-2019
   */
  handleVerifyAllCredentialsClick() {
    console.log("handle verify all");
  }

  /**
   * Method to get all the data from apex after login
   * Created By : Abhishek Kumar Sharma
   * Created date : 23-May-2019
   */
  handleExportAll() {
    console.log("handle export all");
  }

  /**
   * Method to get all the data from apex after login
   * Created By : Abhishek Kumar Sharma
   * Created date : 23-May-2019
   */
  handleAddNewCredentials() {
    console.log("handle add new credentials all");
  }

  /**
   * Method to get all the data from apex after login
   * Created By : Abhishek Kumar Sharma
   * Created date : 23-May-2019
   */
  handleRowButtonActions(event) {
    const actionName = event.detail.action.name;
    const row = event.detail.row;
    switch (actionName) {
      case "view":
        this.showRecordDetails(row, "view");
        break;
      case "edit":
        this.showRecordDetails(row, "edit");
        break;
      case "delete":
        this.openDeleteRecord(row);
        break;
      case "validate":
        this.validateRecord(row);
        break;
      case "login":
        this.loginToOrg(row);
        break;
      case "download":
        this.downloadAsText(row);
        break;
      default:
        console.error(
          "Unable to match any action for data table action. Reload the page if problem still persist contact system administrator with this message"
        );
    }
  }

  /**
   * Method to get all the data from apex after login
   * Created By : Abhishek Kumar Sharma
   * Created date : 23-May-2019
   */
  showRecordDetails(selectedRow, actionName) {
    try {
      this.selectedRecordFromDataTable = selectedRow;
      this.isviewDetails = true;
      if (actionName === "edit") {
        this.isDisabled = false;
        this.modelFooterClass =
          "slds-modal__footer slds-modal__footer_directional";
      } else {
        this.isDisabled = true;
        this.modelFooterClass = "slds-modal__footer";
      }
    } catch (exception) {
      console.error(
        "Exception occureed while getting the record details from data table.\n Please refresh the page and try again.\nMessage ::" +
          exception.message
      );
    }
  }

  /**
   * Method to get all the data from apex after login
   * Created By : Abhishek Kumar Sharma
   * Created date : 23-May-2019
   */
  openDeleteRecord(selectedRow) {
    try {
      if (
        selectedRow !== null &&
        selectedRow.Id !== null &&
        selectedRow.Id !== undefined
      ) {
        console.log("selectedRow openEditRecord==>", selectedRow.Id);
        deleteRecord({
          recordId: selectedRow.Id
        })
          .then(value => {
            console.log("Deleted ==>" + value);
          })
          .catch(error => {
            console.error(
              "Exception occured while deleting the record. \n Message ::" +
                error.body.message
            );
            this.hasPageError =
              "slds-notify slds-notify_alert slds-theme_alert-texture slds-theme_error sdls-m-bottom_small";
            this.errorMessage = error.body.message;
          });
      } else {
        this.hasPageError =
          "slds-notify slds-notify_alert slds-theme_alert-texture slds-theme_error sdls-m-bottom_small";
        this.errorMessage = "Unable to delete record. Record not found";
      }
    } catch (exception) {
      console.error(
        "Exception occurred unable to open record in edit view \n Message ::",
        exception.message
      );
    }
  }

  /**
   * Method to get all the data from apex after login
   * Created By : Abhishek Kumar Sharma
   * Created date : 23-May-2019
   */
  validateRecord(selectedRow) {
    try{
      console.log("selectedRow validateRecord==>", selectedRow);
      console.log("selectedRow validateRecord==>", selectedRow.Id);
    }catch(exception){
        console.error('Exception occurred while validating the record ::'+exception.message);
    }
    
  }

  /**
   * Method to get all the data from apex after login
   * Created By : Abhishek Kumar Sharma
   * Created date : 23-May-2019
   */
  loginToOrg(selectedRow) {
    console.log("selectedRow loginToOrg==>", selectedRow);
  }

  /**
   * Method to prepare and download the data in text file
   * Created By : Abhishek Kumar Sharma
   * Created date : 23-May-2019
   */
  downloadAsText(selectedRow) {
    console.log("selectedRow downloadAsText==>", selectedRow);
  }

  /**
   * Method to close all the pop up
   * Created By : Abhishek Kumar Sharma
   * Created date : 15-June-2019
   */
  handleModalClose(event) {
    try {
      let attributName = event.target.name;
      console.log("attribute name ", attributName);
      if (attributName !== null && attributName !== undefined) {
        switch (attributName) {
          case "isviewDetails":
            this.isviewDetails = false;
            break;
          default:
            console.error(
              "Error while closing the pop up default case. Please contact system administrator with this error message"
            );
            break;
        }
      }
    } catch (exception) {
      this.hasPageError =
        "slds-notify slds-notify_alert slds-theme_alert-texture slds-theme_error sdls-m-bottom_small";
      this.errorMessage = exception.message;
      console.error(
        "Exception occuured while login. \n Message ::" + exception.message
      );
    }
  }
  /**
   * Method to send the modified details to apex class for checking the validity and update iff only valid
   */
  saveModifiedDetails() {
    try {
      updateLoginRecord({
        updatedLoginDetails: this.selectedRecordFromDataTable
      })
        .then(value => {
          if (value !== undefined && value !== null) {
            console.log(JSON.stringify(value));
            this.toastMessage = "Record update successfully";
            this.showToast = true;
            this.isviewDetails = false;
            // eslint-disable-next-line @lwc/lwc/no-async-operation
            setTimeout(() => {
              this.showToast = false;
            }, 3000);
          }
        })
        .catch(error => {
          this.hasPageError =
            "slds-notify slds-notify_alert slds-theme_alert-texture slds-theme_error sdls-m-bottom_small";
          this.errorMessage = error.body.message;
          console.error("Error ", error.body.message);
        });
    } catch (exception) {
      console.error(
        "Exception occurred while verifying the details. Contact System administrator with this message. \n Message ::",
        exception.message
      );
    }
  }

  googleTranslateElementInit() {
    // eslint-disable-next-line no-new
    // new google.translate.TranslateElement({pageLanguage: 'en'}, 'google_translate_element');
  }

  hideToast() {
    this.toastMessage = null;
    this.showToast = false;
  }

  searchTableData(event){
    console.log('hello ===>',this.searchFilter);
    this.searchFilter = event.target.value;
    if(this.searchFilter !== null && this.searchFilter !== undefined){
      //apply search filter
      let data = this.allloginRecords;
      let term = event.target.value;
      let results = data, regex;
  try {
      regex = new RegExp(term, "i");
      // filter checks each row, constructs new array where function returns true
      results = data.filter(row=>regex.test(row.ECSV__Password__c) || regex.test(row.ECSV__User_Name__c.toString()));
      console.log(results);
  } catch(e) {
      // invalid regex, use full list
  }
  this.allloginRecords = results;
    }
    console.log('hello ===>', event.target.value);
  }
} // class closing