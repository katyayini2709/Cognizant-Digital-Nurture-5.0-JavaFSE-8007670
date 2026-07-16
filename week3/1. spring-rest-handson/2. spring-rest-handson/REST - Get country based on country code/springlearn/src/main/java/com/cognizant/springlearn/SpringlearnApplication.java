package com.cognizant.springlearn;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import com.cognizant.springlearn.model.Country;
import com.cognizant.springlearn.service.CountryService;

@SpringBootApplication
public class SpringlearnApplication {
	private static final Logger LOGGER = LoggerFactory.getLogger(SpringlearnApplication.class);
	public static void main(String[] args) {

		LOGGER.info("START");

		SpringApplication.run(SpringlearnApplication.class, args);

		CountryService service = new CountryService();
		Country country = service.getCountry();

		System.out.println(country);

		LOGGER.info("END");
	}

}
