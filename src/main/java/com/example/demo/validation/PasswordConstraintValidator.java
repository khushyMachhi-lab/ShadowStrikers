package com.example.demo.validation;

import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class PasswordConstraintValidator implements ConstraintValidator<ValidPassword, String> {

	// The Regex enforces:
    // 1. (?=.*[A-Z]): At least one uppercase letter
    // 2. (?=.*[a-z]): At least one lowercase letter
    // 3. (?=.*[0-9]): At least one digit
    // 4. (?=.*[!@#$%^&*]): At least one special character
    // 5. .{8,}: Minimum of 8 characters total
    private static final String PASSWORD_PATTERN = 
        "^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$%^&*]).{8,}$";

    private Pattern pattern;
    private Matcher matcher;

    @Override
    public void initialize(ValidPassword constraintAnnotation) {
        // Initialize the Regex Pattern when the validator is created
        pattern = Pattern.compile(PASSWORD_PATTERN);
    }

    @Override
    public boolean isValid(String password, ConstraintValidatorContext context) {
        if (password == null) {
            return false;
        }
        
        // Check if the password matches the required pattern
        matcher = pattern.matcher(password);
        return matcher.matches();
    }

}
