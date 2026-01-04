package com.bank.system.config;

import com.bank.system.model.Account;
import com.bank.system.model.User;
import com.bank.system.repository.AccountRepository;
import com.bank.system.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

import java.math.BigDecimal;

@Component
public class DataInitializer implements CommandLineRunner {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private AccountRepository accountRepository;

    @Override
    public void run(String... args) throws Exception {
        // Check if admin exists
        if (userRepository.findByEmail("admin@bank.com").isEmpty()) {
            User admin = new User();
            admin.setFullName("System Administrator");
            admin.setEmail("admin@bank.com");
            admin.setPassword("admin123"); // In a real app, encrypt this!
            admin.setPhoneNumber("0000000000");
            admin.setAddress("Bank HQ");
            admin.setRole(User.Role.ADMIN);
            admin.setVerified(true);

            userRepository.save(admin);
            System.out.println("ADMIN USER CREATED: admin@bank.com / admin123");
        }

        // Check if a demo customer exists
        if (userRepository.findByEmail("user@bank.com").isEmpty()) {
            User user = new User();
            user.setFullName("John Doe");
            user.setEmail("user@bank.com");
            user.setPassword("user123");
            user.setPhoneNumber("1234567890");
            user.setAddress("123 Main St");
            user.setRole(User.Role.CUSTOMER);
            user.setVerified(true);

            User savedUser = userRepository.save(user);

            Account account = new Account();
            account.setUser(savedUser);
            account.setAccountNumber("AC10000001"); // Fixed account number for demo
            account.setUpiId("1234567890@smartbank");
            account.setBalance(new BigDecimal("5000.00"));
            accountRepository.save(account);

            System.out.println("DEMO USER CREATED: user@bank.com / user123");
        }

        // Check if second demo customer exists
        if (userRepository.findByEmail("jane@bank.com").isEmpty()) {
            User user = new User();
            user.setFullName("Jane Doe");
            user.setEmail("jane@bank.com");
            user.setPassword("jane123");
            user.setPhoneNumber("0987654321");
            user.setAddress("456 Elm St");
            user.setRole(User.Role.CUSTOMER);
            user.setVerified(true);

            User savedUser = userRepository.save(user);

            Account account = new Account();
            account.setUser(savedUser);
            account.setAccountNumber("AC10000002"); // Fixed account number for transfer testing
            account.setUpiId("0987654321@smartbank");
            account.setBalance(new BigDecimal("1000.00"));
            accountRepository.save(account);

            System.out.println("DEMO USER 2 CREATED: jane@bank.com / jane123 (Account: AC10000002)");
        }
    }
}
