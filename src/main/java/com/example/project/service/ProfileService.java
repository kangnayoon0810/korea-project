package com.example.project.service;
import java.io.File;
import java.io.IOException;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.example.project.dao.ProfileDao;
import com.example.project.dto.ProfileDto;

@Service
public class ProfileService {

	@Value("${custom.file.dir}")
	private String fileDir;
	
    private final ProfileDao profileDao;

    public ProfileService(ProfileDao profileDao) {
        this.profileDao = profileDao;
    }

    public ProfileDto getProfileByMemberId(int id) {
        return profileDao.getProfileByMemberId(id);
    }

	public void updateProfileImg(MultipartFile file, int memberId) throws IOException {
		String orgName = file.getOriginalFilename();
		String uuid = UUID.randomUUID().toString();
		String extension = orgName.substring(orgName.lastIndexOf("."));
		String savedName = uuid + extension;
		String profileImagePath = fileDir + "/" + savedName;
		profileDao.updateProfileImg(profileImagePath, memberId);
		
		file.transferTo(new File(profileImagePath));
	}

	public ProfileDto getProfileById(int id) {
		return this.profileDao.getProfileById(id);
	}

	public void modifyInfo(int memberId, String address, String intro) {
		this.profileDao.modifyInfo(memberId, address, intro);
	}
}