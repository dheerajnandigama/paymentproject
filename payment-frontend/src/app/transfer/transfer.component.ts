import { HttpClient } from '@angular/common/http';
import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { DataService } from '../services/data.service';

@Component({
  selector: 'app-transfer',
  templateUrl: './transfer.component.html',
  styleUrls: ['./transfer.component.css']
})
export class TransferComponent implements OnInit {
  message:any;
  transferProfile:any;
  messageCodeList:Array<any>;
  messageCodeDropdownSchema :any;
  TransferTypeDropdownSchema:any;
  // codes=[
  //   "B-Bank to Bank Tranfer",
  //   "C-Customer to Customer Transfer"
  // ]
 
  

  constructor(private router: Router,private datasvc:DataService,private http:HttpClient ) {
    this.transferProfile={
      "receiveraccountholdernumber": '',
      "receiveraccountholdername": '',  
      "receiverBIC":
                    {  "bic":''},
      "inramount": '',
      "customerid": 
                    {  "customerid": localStorage.getItem('customerid') },
       
      "messagecode": {
          "messagecode": ''
          },
     "transfertypecode":{
          "transfertypecode":''
          }
     };

    this.messageCodeList = this.datasvc.getmessageCodeList();
  }  
    onSubmit() {  
        this.router.navigate(['/dashboard'])  
    }  
    messagecodeSelected(data:any){
      // console.log(data);
      this.transferProfile.messagecode.messagecode=data;
    }

    transfertypeSelected(data:any){
      this.transferProfile.transfertypecode.transfertypecode=data;
    }

  ngOnInit(): void {
    this.datasvc.getDataFromApi('http://localhost:8080/messagecodes')
      .subscribe((result: any) => {
        this.messageCodeList = result.map((item: any) => {
          return { name: item.messagecode, code: item.instruction };
        });
        this.messageCodeDropdownSchema={
          labelName:"",
          selectedValue:"",
          controlName:"messagecode",
          options:this.messageCodeList,
          defaultLabel:"Select messagecode"
        }
      }, err => {
        console.log(err);
      })
      
  }
  apiResult={
    success:false,
    error:false
  }

  handleTransfer() {
    let url = 'http://localhost:8080/transactions'
    let payLoad = {
      "receiveraccountholdernumber": this.transferProfile.receiveraccountholdernumber,
      "receiveraccountholdername": this.transferProfile.receiveraccountholdername,  
      "receiverBIC":
                    {  "bic": this.transferProfile.receiverBIC.bic },
      "inramount": this.transferProfile.inramount,
      "customerid": 
                    {  "customerid": localStorage.getItem('customerid') },
       
      "messagecode": {
          "messagecode": this.transferProfile.messagecode.messagecode
          },
     "transfertypecode":{
          "transfertypecode":this.transferProfile.transfertypecode.transfertypecode
          }
     }
    
    
     this.http.post(url, payLoad).subscribe( result => {
      this.message=result;
      console.log(result);
      
    }, err => {
      if(err.status==200){
      // this.apiResult.success=true;
      // this.apiResult.error =false;
      localStorage.setItem("receiver",this.transferProfile.receiveraccountholdername);
      localStorage.setItem("amount",this.transferProfile.inramount);
      this.router.navigate(['/success']) 
    }
      else{
      this.apiResult.success=false;
      this.apiResult.error =true;
      }
    }
    )  
    
  }
  myurl:any;
invalidname:any;
bankname:any;
 
  getbankbybic()
  {
    this.myurl="http://localhost:8080/bank/"+this.transferProfile.receiverBIC.bic;
     let response= this.http .get(this.myurl);
     response.subscribe((data)=>this.bankname=data);
     
     console.log(this.bankname);
  }


}
