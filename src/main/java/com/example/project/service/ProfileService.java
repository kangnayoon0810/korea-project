package com.example.project.service;
import org.springframework.stereotype.Service;

import com.example.project.dao.ProfileDao;
import com.example.project.dto.Profile;

@Service
public class ProfileService {

    private final ProfileDao profileDao;

    public ProfileService(ProfileDao profileDao) {
        this.profileDao = profileDao;
    }

    public Profile getProfileByMemberId(int id) {
        return profileDao.getProfileByMemberId(id);
    }

    public void createDefaultProfile(int memberId) {
        Profile profile = new Profile();
        profile.setMemberId(memberId);
        profile.setProfileImageId(1); // 기본 이미지 ID

        profileDao.insertDefaultProfile(profile); // DAO 통해 직접 INSERT
    }
}