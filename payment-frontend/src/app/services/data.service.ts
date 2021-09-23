import { HttpClient } from "@angular/common/http";
import { Injectable } from "@angular/core";
@Injectable()
export class DataService {
   
    private messageCodeList: any
    private products: any;
    constructor(private http:HttpClient) {
       
    }
     getDataFromApi(url:string){
        return this.http.get(url);
    }
    getmessageCodeList(){
        return this.messageCodeList;
    }
}
 