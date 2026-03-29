package com.example.demo.validation;

import java.lang.annotation.Documented;
import java.lang.annotation.Retention;
import java.lang.annotation.Target;

import jakarta.validation.Constraint;
import jakarta.validation.Payload;

import static java.lang.annotation.ElementType.FIELD;
import static java.lang.annotation.RetentionPolicy.RUNTIME;

@Constraint(validatedBy = PasswordConstraintValidator.class)
@Target({ FIELD }) // Can only be applied to fields
@Retention(RUNTIME)
@Documented
public @interface ValidPassword {
	
	// Define the default error message
    String message() default "Password must be at least 8 characters long, including 1 uppercase, 1 lowercase, 1 digit, and 1 special character (!@#$%^&*).";

    Class<?>[] groups() default {};

    Class<? extends Payload>[] payload() default {};

}
