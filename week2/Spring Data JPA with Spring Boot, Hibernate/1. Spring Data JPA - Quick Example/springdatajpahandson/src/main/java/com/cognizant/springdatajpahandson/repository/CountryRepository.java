package com.cognizant.springdatajpahandson.repository;

import com.cognizant.springdatajpahandson.model.Country;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CountryRepository extends JpaRepository<Country, String> {

}