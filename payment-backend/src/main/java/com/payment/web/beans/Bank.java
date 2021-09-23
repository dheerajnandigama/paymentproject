package com.payment.web.beans;

import javax.persistence.Entity;
import javax.persistence.Id;

@Entity
public class Bank {
	@Id
	private String bic;
	private String bankname;
	public Bank() {
		// TODO Auto-generated constructor stub
	}
	public Bank(String bic, String bankname) {
		super();
		this.bic = bic;
		this.bankname = bankname;
	}
	@Override
	public String toString() {
		return "Bank [bic=" + bic + ", bankname=" + bankname + "]";
	}
	public String getBic() {
		return bic;
	}
	public void setBic(String bic) {
		this.bic = bic;
	}
	public String getBankname() {
		return bankname;
	}
	public void setBankname(String bankname) {
		this.bankname = bankname;
	}
}
