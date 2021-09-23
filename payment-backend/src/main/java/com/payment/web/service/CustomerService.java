package com.payment.web.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import javax.persistence.EntityNotFoundException;

import org.hibernate.internal.build.AllowSysOut;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.payment.web.beans.Bank;
import com.payment.web.beans.Customer;
import com.payment.web.beans.Transaction;
import com.payment.web.repository.CustomerRepository;
import com.payment.web.repository.TransactionRepository;

@Service
public class CustomerService {
	public CustomerService() {
		// TODO Auto-generated constructor stub
	}
	
	@Autowired
	private CustomerRepository custRepository;
	
	public List<Customer> getAllCustomers() {
		List<Customer> c = new ArrayList<Customer>();
		c = (List<Customer>) this.custRepository.findAll();
		return c;
	}
	
	public  Customer findCustomerById(String id)
	{
		try {
			Optional<Customer> cust = this.custRepository.findById(id);

			return cust.orElseThrow(()->{
	
				return new EntityNotFoundException("Customer with "+id + " does not exist");
			});

		}catch(IllegalArgumentException e )
		{
			return null;
		}

	}
	
	public boolean sendMoney(Customer sender, Customer receiver, double amount, double fee) {
		
		
		if (sender.getClearbalance() > amount || sender.getOverdraftflag() == 1) {
			sender.setClearbalance(sender.getClearbalance()-amount-fee);
			custRepository.save(sender);
			System.out.println("Balance : " + sender.getClearbalance());
			
			receiver.setClearbalance(receiver.getClearbalance()+amount);
			return true;
		}
		return false;
	}

	public boolean checkReceiverData(Transaction transaction) {
		int f=1;
		//Receiver Account
		String receiverAccID = transaction.getReceiveraccountholdernumber();
			Customer receiver = this.findCustomerById(receiverAccID);
			//Bank receiverBIC = transaction.getReceiverBIC();
//			System.out.println(receiver);
//			System.out.println(transaction);
			if (!(transaction.getReceiverBIC().getBic()).equalsIgnoreCase(receiver.getcustomerBIC().getBic())) {
				f=0;}
				if(!(transaction.getTransfertypecode().getTransfertypecode()).equalsIgnoreCase(receiver.getCustomertype())) {
					f=0;}
				if	(!transaction.getReceiveraccountholdername().equalsIgnoreCase(receiver.getAccountholdername())) { 
					f=0;
					}
				
		
		if (f==1) return true;
		else return false;
	}
	
}
