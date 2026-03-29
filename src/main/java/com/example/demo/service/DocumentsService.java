package com.example.demo.service;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
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

	public String saveDocument(MultipartFile file) throws IOException {
        
        // 1. ફાઈલનું ઓરિજિનલ નામ મેળવો અને તેને યુનિક બનાવવા માટે ટાઈમસ્ટેમ્પ ઉમેરો
        String fileName = System.currentTimeMillis() + "_" + file.getOriginalFilename();
        
        // 2. ફાઈલ ક્યાં સેવ કરવી તેનો પાથ સેટ કરો (static/documents ફોલ્ડર)
        // નોંધ: આ પાથ તમારા પ્રોજેક્ટના સ્ટ્રક્ચર મુજબ હોવો જોઈએ
        String uploadDir = "src/main/resources/static/documents/";
        Path uploadPath = Paths.get(uploadDir);
        
        // 3. જો ડિરેક્ટરી (ફોલ્ડર) અસ્તિત્વમાં ન હોય, તો તેને બનાવો
        if (!Files.exists(uploadPath)) {
            Files.createDirectories(uploadPath);
        }
        
        // 4. ફાઈલને નિર્ધારિત લોકેશન પર કોપી કરો
        try {
            Path filePath = uploadPath.resolve(fileName);
            Files.copy(file.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);
        } catch (IOException e) {
            throw new IOException("Could not save file: " + fileName, e);
        }
        
        // 5. ડેટાબેઝમાં સેવ કરવા માટે ફાઈલનું નામ રિટર્ન કરો
        return fileName;
    }
	
    // ડોક્યુમેન્ટને ID દ્વારા મેળવવા
    public Optional<Documents> getDocumentById(Long id) {
        return documentsRepository.findById(id);
    }

    // સ્ટેટસ અપડેટ કરવાનું મુખ્ય લોજિક
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
        // આનાથી User નું લિસ્ટ આવશે જેમાં firstName પહેલેથી જ છે
        return userRepository.findAllByOrderByIdDesc(); 
    }

}
