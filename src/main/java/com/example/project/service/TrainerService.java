package com.example.project.service;

import org.springframework.stereotype.Service;

import com.example.project.dao.TrainerDao;
import com.example.project.dto.Member;
import com.example.project.dto.Trainer;

@Service
public class TrainerService {

	private TrainerDao trainerDao;

	public TrainerService(TrainerDao trainerDao) {
		this.trainerDao = trainerDao;
	}

	public void signupTrainer(String name, int sex, int phoneNumber, String loginId, String loginPw, String eMail) {
		this.trainerDao.signupTrainer(name, sex, phoneNumber, loginId, loginPw, eMail);
	}

	public Trainer getTrainerByPhoneNumber(int phoneNumber) {
		return this.trainerDao.getTrainerByPhoneNumber(phoneNumber);
	}

	public Trainer getTrainerByLoginId(String loginId) {
		return this.trainerDao.getTrainerByLoginId(loginId);
	}

	public Trainer getTrainerByEMail(String eMail) {
		return this.trainerDao.getTrainerByEMail(eMail);
	}

	public Trainer loginedTrainerId(String loginId, String loginPw) {
		return this.trainerDao.loginedTrainerId(loginId, loginPw);
	}

}