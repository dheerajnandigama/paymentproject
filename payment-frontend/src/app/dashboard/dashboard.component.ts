import { HttpClient } from '@angular/common/http';
import { Component, OnInit } from '@angular/core';
import { Router  } from '@angular/router';  
@Component({
  selector: 'app-dashboard',
  templateUrl: './dashboard.component.html',
  styleUrls: ['./dashboard.component.css']
})
export class DashboardComponent implements OnInit {

  url:any;
  customer:any;
  customerid:any;
  constructor(private router: Router ,private http:HttpClient ) {
    this.url="http://localhost:8080/customer/"+localStorage.getItem('customerid');
  }  
  onSubmit() {  
      this.router.navigate(['/transfer'])  
  }
  onRecent() {  
    this.router.navigate(['/transactions'])  
}

  ngOnInit(){
     let response= this.http.get(this.url);
     response.subscribe((data)=>this.customer=data);
  }

}
