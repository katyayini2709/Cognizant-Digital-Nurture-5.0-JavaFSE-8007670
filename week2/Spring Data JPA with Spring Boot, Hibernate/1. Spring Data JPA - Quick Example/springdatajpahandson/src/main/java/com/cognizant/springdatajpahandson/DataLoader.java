package com.cognizant.springdatajpahandson;

import com.cognizant.springdatajpahandson.model.Country;
import com.cognizant.springdatajpahandson.repository.CountryRepository;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

@Component
public class DataLoader implements CommandLineRunner {

    private final CountryRepository repository;

    public DataLoader(CountryRepository repository) {
        this.repository = repository;
    }

    @Override
    public void run(String... args) {

        repository.save(new Country("IN", "India"));
        repository.save(new Country("US", "United States"));

        System.out.println(repository.findAll());
    }
}