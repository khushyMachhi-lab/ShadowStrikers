package com.example.demo.service;

import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.example.demo.model.BatchTime;
import com.example.demo.model.User;
import com.example.demo.repository.BatchTimeRepository;
import com.example.demo.repository.UserRepository;
import com.google.api.client.auth.oauth2.Credential;
import com.google.api.client.googleapis.javanet.GoogleNetHttpTransport;

import com.google.api.client.json.gson.GsonFactory;
import com.google.api.services.calendar.Calendar;
import com.google.api.services.calendar.CalendarScopes;

import jakarta.transaction.Transactional;

@Service
public class BatchTimeService {
	
	@Value("${google.client.id}")
    private String clientId;

    @Value("${google.client.secret}")
    private String clientSecret;

    @Value("${google.refresh.token}")
    private String refreshToken;
	
	@Autowired
    private BatchTimeRepository batchTimeRepository;
	
	@Autowired
	private UserRepository userRepository;
	
	public List<BatchTime> getAllBatches() {
        return batchTimeRepository.findAllByOrderByStartTimeAsc();
    }

    public void saveBatch(BatchTime batch) {
        batchTimeRepository.save(batch);
    }
    
    public BatchTime getBatchById(Long id) {
        return batchTimeRepository.findById(id).orElse(null);
    }

	public void deleteBatchById(Long id) {
		batchTimeRepository.deleteById(id);
	}
	
    private static final List<String> SCOPES = Collections.singletonList(CalendarScopes.CALENDAR);
    private static final GsonFactory JSON_FACTORY = GsonFactory.getDefaultInstance();

    public String generateGoogleMeetLink(String batchName) {
        try {
            Calendar service = getCalendarService();

            com.google.api.services.calendar.model.Event event = new com.google.api.services.calendar.model.Event()
                .setSummary("Batch: " + batchName)
                .setDescription("Online Class link generated via Portal");

            // Timing (Current time thi 1 hour)
            com.google.api.client.util.DateTime now = new com.google.api.client.util.DateTime(System.currentTimeMillis());
            event.setStart(new com.google.api.services.calendar.model.EventDateTime().setDateTime(now).setTimeZone("Asia/Kolkata"));
            event.setEnd(new com.google.api.services.calendar.model.EventDateTime().setDateTime(new com.google.api.client.util.DateTime(System.currentTimeMillis() + 3600000)).setTimeZone("Asia/Kolkata"));

            // Meet link request
            com.google.api.services.calendar.model.ConferenceSolutionKey solutionKey = new com.google.api.services.calendar.model.ConferenceSolutionKey().setType("hangoutsMeet");
            com.google.api.services.calendar.model.CreateConferenceRequest createRequest = new com.google.api.services.calendar.model.CreateConferenceRequest()
                .setRequestId(java.util.UUID.randomUUID().toString())
                .setConferenceSolutionKey(solutionKey);
            event.setConferenceData(new com.google.api.services.calendar.model.ConferenceData().setCreateRequest(createRequest));

            event = service.events().insert("primary", event)
                .setConferenceDataVersion(1)
                .execute();

            return event.getHangoutLink();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    private Credential getCredentials() throws Exception {
        return new com.google.api.client.googleapis.auth.oauth2.GoogleCredential.Builder()
                .setTransport(GoogleNetHttpTransport.newTrustedTransport())
                .setJsonFactory(JSON_FACTORY)
                .setClientSecrets(clientId, clientSecret)
                .build()
                .setRefreshToken(refreshToken);
    }

    private Calendar getCalendarService() throws Exception {
        return new Calendar.Builder(GoogleNetHttpTransport.newTrustedTransport(), JSON_FACTORY, getCredentials())
                .setApplicationName("Student Registration Portal")
                .build();
    }
    
    @Transactional
    public void updateBatchLiveStatus(Long batchId, boolean status) {
        BatchTime batch = batchTimeRepository.findById(batchId)
                .orElseThrow(() -> new RuntimeException("Batch not found with ID: " + batchId));
        
        batch.setLive(status);
        batchTimeRepository.save(batch);
    }
    
    public boolean isBatchLive(Long batchId) {
        return batchTimeRepository.findById(batchId)
                .map(BatchTime::isLive)
                .orElse(false);
    }
    
    @Transactional
    public void assignBatchToStudent(int userId, Long batchId) {
        User user = userRepository.findById(userId).orElse(null);
        BatchTime batch = batchTimeRepository.findById(batchId).orElse(null);
        
        if (user != null && batch != null) {
            user.setBatch(batch);
            userRepository.save(user);
        }
    }
	
}
	
	
	


