package com.example.project.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.example.project.dao.FavoriteTrainerDao;
import com.example.project.dto.Member;

@Service
public class FavoriteTrainerService {

    private final FavoriteTrainerDao favoriteTrainerDao;

    public FavoriteTrainerService(FavoriteTrainerDao favoriteTrainerDao) {
        this.favoriteTrainerDao = favoriteTrainerDao;
    }

    public boolean toggleFavorite(int memberId, int trainerId) {
        if (favoriteTrainerDao.isFavorited(memberId, trainerId)) {
            favoriteTrainerDao.delete(memberId, trainerId);
            return false;
        } else {
            favoriteTrainerDao.insert(memberId, trainerId);
            return true;
        }
    }

    public boolean isFavorited(int memberId, int trainerId) {
        return favoriteTrainerDao.isFavorited(memberId, trainerId);
    }

	public List<Member> getFavoriteTrainers(int memberId) {
		return this.favoriteTrainerDao.getFavoriteTrainers(memberId);
	}
}

