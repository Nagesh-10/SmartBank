package com.bank.system.service;

import com.bank.system.model.SavingsGoal;
import com.bank.system.model.User;
import com.bank.system.repository.SavingsGoalRepository;
import com.bank.system.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SavingsGoalService {

    @Autowired
    private SavingsGoalRepository savingsGoalRepository;

    @Autowired
    private UserRepository userRepository;

    public List<SavingsGoal> getGoalsByUserId(Long userId) {
        return savingsGoalRepository.findByUserId(userId);
    }

    public void addGoal(Long userId, SavingsGoal goal) {
        User user = userRepository.findById(userId).orElse(null);
        if (user != null) {
            goal.setUser(user);
            savingsGoalRepository.save(goal);
        }
    }
}
