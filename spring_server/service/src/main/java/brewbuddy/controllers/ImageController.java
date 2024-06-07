package brewbuddy.controllers;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.net.MalformedURLException;
import java.nio.file.Path;
import java.nio.file.Paths;

@RestController
@RequestMapping("/api/image")
public class ImageController {

    @Value("${beer.image.path}")
    private String beerImagePath;

    @Value("${brewery.image.path}")
    private String breweryImagePath;

    public ImageController() {
    }


    @ResponseBody
    @RequestMapping(path="/beer/{filename:.+}", method = RequestMethod.GET)
    public ResponseEntity<Resource> getBeerImage(@PathVariable String filename) {
        return getImage(filename, beerImagePath);
    }

    @ResponseBody
    @RequestMapping(path="/brewery/{filename:.+}", method = RequestMethod.GET)
    public ResponseEntity<Resource> getBreweryImage(@PathVariable String filename) {
        return getImage(filename, breweryImagePath);
    }

    private ResponseEntity<Resource> getImage(String filename, String imagePath) {
        try {
            Path file = Paths.get(imagePath).resolve(filename + ".png");
            Resource resource = new UrlResource(file.toUri());

            if (resource.exists() || resource.isReadable()) {
                HttpHeaders headers = new HttpHeaders();
                headers.setContentDispositionFormData("attachment", resource.getFilename());
                headers.setContentType(MediaType.IMAGE_PNG);
                return new ResponseEntity<>(resource, headers, HttpStatus.OK);
            } else {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
            }
        } catch (MalformedURLException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }
    }

}
