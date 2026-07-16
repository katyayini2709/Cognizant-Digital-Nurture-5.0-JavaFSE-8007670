package com.cognizant.springlearn.service;

import com.cognizant.springlearn.model.Country;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Service;

@Service
public class CountryService {

    public Country getCountry() {
        ClassPathXmlApplicationContext context =
                new ClassPathXmlApplicationContext("country.xml");

        return context.getBean("country", Country.class);
    }

    public Country getCountry(String code) {

        if(code.equalsIgnoreCase("IN")) {
            return new Country("IN", "India");
        }
        else if(code.equalsIgnoreCase("US")) {
            return new Country("US", "United States");
        }
        else if(code.equalsIgnoreCase("JN")) {
            return new Country("JN", "Japan");
        }

        return null;
    }
}