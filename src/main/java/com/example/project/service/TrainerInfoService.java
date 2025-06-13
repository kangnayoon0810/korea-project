package com.example.project.service;

import org.springframework.stereotype.Service;

import com.example.project.dao.TrainerInfoDao;
import com.example.project.dto.TrainerInfo;

@Service
public class TrainerInfoService {

	private TrainerInfoDao trainerInfoDao;

	public TrainerInfoService(TrainerInfoDao trainerInfoDao) {
		this.trainerInfoDao = trainerInfoDao;
	}

	public TrainerInfo getTrainerInfoByProfileId(int id) {
		return this.trainerInfoDao.getTrainerInfoByProfileId(id);
	}
	
}