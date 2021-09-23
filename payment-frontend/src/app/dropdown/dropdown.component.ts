import { Component, EventEmitter, Input, OnInit, Output } from '@angular/core';

@Component({
  selector: 'app-dropdown',
  templateUrl: './dropdown.component.html',
  styleUrls: ['./dropdown.component.css']
})
export class DropdownComponent implements OnInit {
  @Input()
  schema:any;
  //creating output decorator
  @Output()
  handleChange:EventEmitter<any>;
  
  constructor() {
    this.schema={
      options:[{name:"",key:""}],
      labelName:'',
      cssClass:"",
      selectedValue:"",
      controlName:""
    }
    //initilaize output
    this.handleChange=new EventEmitter<any>();
   }
   //handle dropdown change
   handleDropdownChange(event: any){
     //emit dropdown selected value
     
     
     this.handleChange.emit(event.target.value);
   }

  ngOnInit(): void {
  }

}
