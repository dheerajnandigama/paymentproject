import { Component } from "@angular/core";
@Component({
    selector:'app-header',
    templateUrl:'header.component.html',
    styleUrls:['./header.component.css']
})
export class HeaderComponent {
    companyDetails:any
    constructor(){
        this.companyDetails={
            name:'DBS',
            logo:"https://upload.wikimedia.org/wikipedia/commons/thumb/0/0a/Faster_Payments_logo.svg/800px-Faster_Payments_logo.svg.png"
        }
    }
}