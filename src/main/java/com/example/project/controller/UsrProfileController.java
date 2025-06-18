package com.example.project.controller;
import java.io.IOException;

import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.example.project.dto.Article;
import com.example.project.dto.Board;
import com.example.project.dto.Member;
import com.example.project.dto.ProfileDto;
import com.example.project.dto.Req;
import com.example.project.dto.TrainerInfo;
import com.example.project.service.MemberService;
import com.example.project.service.ProfileService;
import com.example.project.service.TrainerInfoService;
import com.example.project.util.Util;

@Controller
public class UsrProfileController {

	private ProfileService profileService;
	private TrainerInfoService trainerInfoService;
	private MemberService memberService;
	private Req req;

	public UsrProfileController(ProfileService profileService, TrainerInfoService trainerInfoService,MemberService memberService,  Req req) {
		this.profileService = profileService;
		this.trainerInfoService = trainerInfoService;
		this.memberService = memberService;
		this.req = req;
	}
	
	@GetMapping("/usr/profile/myPage")
	public String showMyProfile(Model model) {
		int loginedMemberId = req.getLoginedMember().getId();
		
	    ProfileDto profile = profileService.getProfileByMemberId(req.getLoginedMember().getId());
	    
	    Member member = memberService.getMemberById(this.req.getLoginedMember().getId());

	    // 트레이너 정보 가져오기
	    if (req.getLoginedMember().getAuthLevel() == 2) {
	        TrainerInfo trainerInfo = trainerInfoService.getTrainerInfoByProfileId(loginedMemberId);
	        model.addAttribute("trainerInfo", trainerInfo);
	    }
	    
	    model.addAttribute("profile", profile);
	    model.addAttribute("member", member);

	    return "usr/profile/myPage";
	}
	
	@GetMapping("/usr/profile/modify")
	String modify(int id, String nickName, String phoneNumber, String email, int memberId, String address, String intro) {
		
		this.memberService.modifyMember(id, nickName, phoneNumber, email);
		this.profileService.modifyInfo(memberId, address, intro);
		
		return "redirect:/usr/profile/myPage";
	}
	
	@GetMapping("/usr/profile/modifyPwPop")
	public String modifyPwPop() {
		return "usr/profile/modifyPwPop";
	}
	
	@PostMapping("/usr/profile/doModifyPw")
	@ResponseBody
	public String doModifyPw(String loginPw) {
		
		this.memberService.modifyPassword(req.getLoginedMember().getId(), Util.encryptSHA256(loginPw));
		
		return "비밀번호 변경이 완료되었습니다";
	}
	
	@PostMapping("/usr/profile/upload")
	public String profileUpload(MultipartFile profileImg) throws IOException {
		
		if (profileImg.isEmpty()) {
			return Util.jsReplace("파일이 선택되지 않았습니다", null);
		}
		this.profileService.updateProfileImg(profileImg, req.getLoginedMember().getId());
		
		return "redirect:/usr/profile/myPage";
	}
	
	@GetMapping("/usr/profile/image/{profileId}")
	@ResponseBody
	public Resource profileLoad(Model model, @PathVariable int profileId) throws IOException {
		
		ProfileDto profileDto = profileService.getProfileById(profileId);
		
		return new UrlResource("file:" + profileDto.getProfileImagePath());
	}
	
}