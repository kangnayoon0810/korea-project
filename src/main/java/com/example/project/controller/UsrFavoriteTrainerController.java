package com.example.project.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.example.project.dto.Member;
import com.example.project.dto.Req;
import com.example.project.service.FavoriteTrainerService;

@Controller
public class UsrFavoriteTrainerController {

    private final FavoriteTrainerService favoriteTrainerService;
    private final Req req;

    public UsrFavoriteTrainerController(FavoriteTrainerService favoriteTrainerService, Req req) {
        this.favoriteTrainerService = favoriteTrainerService;
        this.req = req;
    }

    // 즐겨찾기 토글 API
    @PostMapping("/usr/favoriteTrainer/toggle")
    @ResponseBody
    public String toggleFavorite(@RequestParam int trainerId) {
        int loginedMemberId = req.getLoginedMember().getId();

        boolean isFavorited = favoriteTrainerService.toggleFavorite(loginedMemberId, trainerId);

        return isFavorited ? "add" : "remove"; // add: 즐겨찾기 추가됨, remove: 즐겨찾기 해제됨
    }

    // 즐겨찾기 여부 확인 API (선택사항, 조건부 렌더링용)
    @GetMapping("/usr/favoriteTrainer/check")
    @ResponseBody
    public boolean isFavorited(@RequestParam int trainerId) {
        int loginedMemberId = req.getLoginedMember().getId();
        return favoriteTrainerService.isFavorited(loginedMemberId, trainerId);
    }
    
    @PostMapping("/usr/favoriteTrainer/add")
    public String doFavoriteAdd(@RequestParam int trainerId) {
        int loginedMemberId = req.getLoginedMember().getId();
        
        favoriteTrainerService.toggleFavorite(loginedMemberId, trainerId);
        
        return "redirect:/usr/article/list?memberCategory=2";
    }
    
    @GetMapping("/usr/favoriteTrainer/list")
    public String showMyFavoriteTrainerList(Model model) {
        int loginedMemberId = req.getLoginedMember().getId();
        
        // 즐겨찾기한 트레이너 리스트 가져오기
        List<Member> favoriteTrainers = favoriteTrainerService.getFavoriteTrainers(loginedMemberId);

        model.addAttribute("favoriteTrainers", favoriteTrainers);
        return "usr/favoriteTrainer/list";
    }


}
