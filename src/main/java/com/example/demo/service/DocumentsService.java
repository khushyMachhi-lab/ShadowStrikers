package com.example.demo.service;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.example.demo.model.Admissions;
import com.example.demo.model.Documents;
import com.example.demo.model.User;
import com.example.demo.repository.AdmissionsRepository;
import com.example.demo.repository.DocumentsRepository;
import com.example.demo.repository.UserRepository;

@Service
public class DocumentsService {

	@Autowired
    private DocumentsRepository documentsRepository;

	@Autowired
	private UserRepository userRepository;

	@Value("${file.documents-dir:./src/main/resources/static/documents/}")
	private String documentsUploadDir;

	public String saveDocument(MultipartFile file) throws IOException {

        String fileName = System.currentTimeMillis() + "_" + file.getOriginalFilename();
        Path uploadPath = Paths.get(documentsUploadDir);

        if (!Files.exists(uploadPath)) {
            Files.createDirectories(uploadPath);
        }

        try {
            Path filePath = uploadPath.resolve(fileName);
            Files.copy(file.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);
        } catch (IOException e) {
            throw new IOException("Could not save file: " + fileName, e);
        }

        return fileName;
    }

    public Optional<Documents> getDocumentById(Long id) {
        return documentsRepository.findById(id);
    }

    public void updateStatus(Long docId, String status, String remarks) {
        documentsRepository.findById(docId).ifPresent(doc -> {
            doc.setStatus(status);
            if (remarks != null) {
                doc.setRemarks(remarks);
            } else {
                doc.setRemarks("");
            }
            documentsRepository.save(doc);
        });
    }

    public List<User> getAllUsersWithDocs() {
        return userRepository.findAllByOrderByIdDesc();
    }

}