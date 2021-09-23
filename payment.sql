-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: localhost:8889
-- Generation Time: Aug 02, 2021 at 09:16 AM
-- Server version: 5.7.25
-- PHP Version: 7.3.1
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";
--
-- Database: `payment`
--
-- --------------------------------------------------------
--
-- Table structure for table `bank`
--
CREATE TABLE `bank` (
  `bic` char(11) NOT NULL,
  `bankname` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
--
-- Dumping data for table `bank`
--
INSERT INTO `bank` (`bic`, `bankname`) VALUES
('ABBLINBBXXX', 'AB BANK LIMITED'),
('ABNAINBBAHM', 'ABN AMRO BANK N.V.'),
('HDFC0000128', 'HDFC BANK -(CHENNAI)'),
('ACBLINBBXXX', 'ABHYUDAYA CO-OPERATIVE BANK LTD.');
-- --------------------------------------------------------
--
-- Table structure for table `currency`
--
CREATE TABLE `currency` (
  `currencycode` char(3) NOT NULL,
  `currencyname` varchar(100) NOT NULL,
  `conversionrate` decimal(10,0) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
--
-- Dumping data for table `currency`
--
INSERT INTO `currency` (`currencycode`, `currencyname`, `conversionrate`) VALUES
('EUR', 'Euro', '84'),
('GBP', 'Great British Pound', '102'),
('INR', 'Indian Rupees', '1'),
('JPY', 'Japanese Yen', '1'),
('USD', 'US Dollar', '74');
-- --------------------------------------------------------
--
-- Table structure for table `customer`
--
CREATE TABLE `customer` (
  `customerid` char(14) NOT NULL,
  `accountholdername` varchar(50) NOT NULL,
  `overdraftflag` tinyint(1) NOT NULL DEFAULT '0',
  `clearbalance` decimal(10,0) NOT NULL,
  `customeraddress` varchar(100) NOT NULL,
  `customercity` varchar(100) NOT NULL,
  `customertype` char(1) NOT NULL,
`customerBIC` char(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
--
-- Dumping data for table `customer`
--
INSERT INTO `customer` (`customerid`, `accountholdername`, `overdraftflag`, `clearbalance`, `customeraddress`, `customercity`, `customertype`, `customerBIC`) VALUES
('69652133523248', 'HDFC BANK -(CHENNAI)', 1, '223997', '', '', 'B','HDFC0000128'),
('71319440983198', 'A M MAYANNA', 0, '221470', '', '', 'I','ACBLINBBXXX'),
('83020817828620', 'A KRISHNA MOHAN', 1, '56000', '', '', 'I','ABNAINBBAHM');
-- --------------------------------------------------------
--
-- Table structure for table `customeruser`
--
CREATE TABLE `customeruser` (
`userid` int(11) NOT NULL,
`username` varchar(100) NOT NULL,
`customerid` char(14) NOT NULL,
`userpassword` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
--
-- Dumping data for table `customeruser`
--
INSERT INTO `customeruser` (`userid`, `username`, `customerid`, `userpassword`) VALUES
(1, 'Shalini Mittal', '69652133523248', 'shalini');
-- --------------------------------------------------------
--
-- Table structure for table `employee`
--
CREATE TABLE `employee` (
`employeeid` int(11) NOT NULL,
`employeename` varchar(100) NOT NULL,
`employeepassword` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------
--
-- Table structure for table `logger`
--
CREATE TABLE `logger` (
  `loggerid` int(11) NOT NULL,
  `customerid` char(14) NOT NULL,
  `userid` int(11) DEFAULT NULL,
  `employeeid` int(11) DEFAULT NULL,
  `screename` varchar(100) DEFAULT NULL,
  `action` varchar(100) DEFAULT NULL,
  `ipaddress` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
--
-- Dumping data for table `logger`
--
INSERT INTO `logger` (`loggerid`, `customerid`, `userid`, `employeeid`, `screename`, `action`, `ipaddress`) VALUES
(1, '71319440983198', NULL, NULL, 'Initiate Payment', 'Payment Transfer', '192.168.1.1');
-- --------------------------------------------------------
--
-- Table structure for table `message`
--
CREATE TABLE `message` (
  `messagecode` char(4) NOT NULL,
  `instruction` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
--
-- Dumping data for table `message`
--
INSERT INTO `message` (`messagecode`, `instruction`) VALUES
('CHQB', 'beneficiary customer must be paid by cheque only.'),
('CORT', 'Payment is made in settlement for a trade.'),
('HOLD', 'Beneficiary customer or claimant will call upon identification.'),
('INTC', 'Payment between two companies that belongs to the same group.'),
('PHOB', 'Please advise the intermediary institution by phone.'),
('PHOI', 'Please advise the intermediary by phone.'),
('PHON', 'Please advise the account with institution by phone.'),
('REPA', 'Payments has a related e-Payments reference.'),
('SDVA', 'Payment must be executed with same day value to the');
-- --------------------------------------------------------
--
-- Table structure for table `transaction`
--
CREATE TABLE `transaction` (
  `transactionid` int(11) NOT NULL,
  `customerid` char(14) NOT NULL,
  `currencycode` char(3) NOT NULL DEFAULT 'INR',
  `senderBIC` char(11) NOT NULL,
  `receiverBIC` char(11) DEFAULT NULL,
  `receiveraccountholdernumber` char(11) NOT NULL,
  `receiveraccountholdername` varchar(100) NOT NULL,
  `transfertypecode` char(1) NOT NULL,
  `messagecode` char(4) NOT NULL,
  `currencyamount` decimal(10,0) NOT NULL DEFAULT '0',
  `transferfees` decimal(10,0) NOT NULL,
  `inramount` decimal(10,0) NOT NULL,
  `transferdate` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
--
-- Dumping data for table `transaction`
--
INSERT INTO `transaction` (`transactionid`, `customerid`, `currencycode`, `senderBIC`, `receiverBIC`, `receiveraccountholdernumber`, `receiveraccountholdername`, `transfertypecode`, `messagecode`, `currencyamount`, `transferfees`, `inramount`, `transferdate`) VALUES
(1, '71319440983198', 'INR', 'ACBLINBBXXX', NULL, '123456', 'trial', 'C', 'PHOI', '1', '10', '1000', '2021-05-10'),
(5, '71319440983198', 'INR', 'ACBLINBBXXX', NULL, '9999999999', 'shalini', 'C', 'REPA', '1', '30', '2500', '2021-06-16');
-- --------------------------------------------------------
--
-- Table structure for table `transfertypes`
--
CREATE TABLE `transfertypes` (
  `transfertypecode` char(1) NOT NULL,
  `transfertypedescription` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
--
-- Dumping data for table `transfertypes`
--
INSERT INTO `transfertypes` (`transfertypecode`, `transfertypedescription`) VALUES
('B', 'Bank Transfer'),
('C', 'Customer Transfer'),
('O', 'Bank Transfer for Own Account');
--
-- Indexes for dumped tables
--
--
-- Indexes for table `bank`
--
ALTER TABLE `bank`
  ADD PRIMARY KEY (`bic`);
--
-- Indexes for table `currency`
--
ALTER TABLE `currency`
  ADD PRIMARY KEY (`currencycode`);
--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`customerid`),
  ADD UNIQUE KEY `accountholdername` (`accountholdername`),
  ADD KEY `customerBIC` (`customerBIC`);
--
-- Indexes for table `customeruser`
--
ALTER TABLE `customeruser`
  ADD PRIMARY KEY (`userid`),
  ADD UNIQUE KEY `username` (`username`),
  ADD KEY `customerid` (`customerid`);
--
-- Indexes for table `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`employeeid`);
--
-- Indexes for table `logger`
--
ALTER TABLE `logger`
  ADD PRIMARY KEY (`loggerid`),
  ADD KEY `employeeid` (`employeeid`),
  ADD KEY `userid` (`userid`),
  ADD KEY `logger_ibfk_1` (`customerid`);
--
-- Indexes for table `message`
--
ALTER TABLE `message`
  ADD PRIMARY KEY (`messagecode`);
--
-- Indexes for table `transaction`
--
ALTER TABLE `transaction`
  ADD PRIMARY KEY (`transactionid`),
  ADD KEY `currencycode` (`currencycode`),
  ADD KEY `messagecode` (`messagecode`),
  ADD KEY `receiverBIC` (`receiverBIC`),
  ADD KEY `senderBIC` (`senderBIC`),
  ADD KEY `transfertypecode` (`transfertypecode`),
  ADD KEY `transaction_ibfk_2` (`customerid`);
--
-- Indexes for table `transfertypes`
--
ALTER TABLE `transfertypes`
  ADD PRIMARY KEY (`transfertypecode`);
--
-- AUTO_INCREMENT for dumped tables
--
--
-- AUTO_INCREMENT for table `logger`
--
ALTER TABLE `logger`
  MODIFY `loggerid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `transaction`
--
ALTER TABLE `transaction`
  MODIFY `transactionid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- Constraints for dumped tables
--
--
-- Constraints for table `customeruser`
--
ALTER TABLE `customeruser`
  ADD CONSTRAINT `customeruser_ibfk_1` FOREIGN KEY (`customerid`) REFERENCES `customer` (`customerid`);
--
-- Constraints for table `logger`
--
ALTER TABLE `logger`
  ADD CONSTRAINT `logger_ibfk_1` FOREIGN KEY (`customerid`) REFERENCES `customer` (`customerid`),
  ADD CONSTRAINT `logger_ibfk_2` FOREIGN KEY (`employeeid`) REFERENCES `employee` (`employeeid`),
  ADD CONSTRAINT `logger_ibfk_3` FOREIGN KEY (`userid`) REFERENCES `customeruser` (`userid`);

--
-- Constraints for table `customer`
--
ALTER TABLE `customer`
  ADD CONSTRAINT `customer_ibfk_1` FOREIGN KEY (`customerBIC`) REFERENCES `bank` (`bic`);
--
-- Constraints for table `transaction`
--
ALTER TABLE `transaction`
  ADD CONSTRAINT `transaction_ibfk_1` FOREIGN KEY (`currencycode`) REFERENCES `currency` (`currencycode`),
  ADD CONSTRAINT `transaction_ibfk_2` FOREIGN KEY (`customerid`) REFERENCES `customer` (`customerid`),
  ADD CONSTRAINT `transaction_ibfk_3` FOREIGN KEY (`messagecode`) REFERENCES `message` (`messagecode`),
  ADD CONSTRAINT `transaction_ibfk_4` FOREIGN KEY (`receiverBIC`) REFERENCES `bank` (`bic`),
  ADD CONSTRAINT `transaction_ibfk_5` FOREIGN KEY (`senderBIC`) REFERENCES `bank` (`bic`),
  ADD CONSTRAINT `transaction_ibfk_6` FOREIGN KEY (`transfertypecode`) REFERENCES `transfertypes` (`transfertypecode`);