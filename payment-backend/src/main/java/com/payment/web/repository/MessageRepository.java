package com.payment.web.repository;

import org.springframework.data.repository.CrudRepository;

import com.payment.web.beans.Message;

public interface MessageRepository extends CrudRepository<Message, String>{

}
