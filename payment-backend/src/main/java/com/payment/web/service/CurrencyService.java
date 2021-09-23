package com.payment.web.service;
import java.util.Optional;
import javax.persistence.EntityNotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.payment.web.beans.Currency;
import com.payment.web.beans.Customer;
import com.payment.web.repository.CurrencyRepository;
@Service
public class CurrencyService {
	@Autowired
	private CurrencyRepository currencyRepository;
	
	public Currency getCurrencyByCode(String currencycode) {
		try {
			Optional<Currency> currency = this.currencyRepository.findById(currencycode);;
			return currency.orElseThrow(()->{
	
				return new EntityNotFoundException("Currency with "+currencycode + " does not exist");
			});
		}catch(IllegalArgumentException e )
		{
			return null;
		} 
	}
}
