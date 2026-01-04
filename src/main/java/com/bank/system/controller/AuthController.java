package com.bank.system.controller;

import com.bank.system.model.User;
import com.bank.system.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class AuthController {

    @Autowired
    private UserService userService;

    @GetMapping("/")
    public String home() {
        return "redirect:/login";
    }

    @GetMapping("/login")
    public String loginPage() {
        return "login";
    }

    @PostMapping("/login")
    public String login(@RequestParam String email, @RequestParam String password, HttpSession session, Model model) {
        User user = userService.loginUser(email, password);
        if (user != null) {
            session.setAttribute("user", user);
            if (user.getRole() == User.Role.ADMIN) {
                return "redirect:/admin/dashboard";
            }
            return "redirect:/dashboard";
        }
        model.addAttribute("error", "Invalid email or password (or account not verified)");
        return "login";
    }

    @GetMapping("/register")
    public String registerPage() {
        return "register";
    }

    @PostMapping("/register")
    public String register(@ModelAttribute User user, Model model) {
        user.setRole(User.Role.CUSTOMER); // Default role
        try {
            userService.registerUser(user);
            return "redirect:/verify-otp?email=" + user.getEmail();
        } catch (Exception e) {
            String errorMsg = "Registration failed: " + e.getMessage();
            if (e.getMessage() != null && e.getMessage().contains("Duplicate entry")) {
                errorMsg = "This email is already registered. Please login or use a different email.";
            }
            model.addAttribute("error", errorMsg);
            return "register";
        }
    }

    @GetMapping("/verify-otp")
    public String verifyOtpPage(@RequestParam String email, Model model) {
        model.addAttribute("email", email);
        return "otp_verify";
    }

    @PostMapping("/verify-otp")
    public String verifyOtp(@RequestParam String email, @RequestParam String otp, Model model) {
        if (userService.verifyUser(email, otp)) {
            return "redirect:/login?success=Account verified successfully. Please login.";
        } else {
            model.addAttribute("error", "Invalid OTP");
            model.addAttribute("email", email);
            return "otp_verify";
        }
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
}
