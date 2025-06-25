package com.example.project.controller;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;

import com.example.project.dto.Member;
import com.example.project.dto.Req;
import com.example.project.dto.TrainerInfo;
import com.example.project.service.MemberService;
import com.example.project.service.ProfileService;
import com.example.project.service.TrainerInfoService;

@Controller
public class UsrTrainerController {

	private ProfileService profileService;
	private TrainerInfoService trainerInfoService;
	private MemberService memberService;
	private Req req;

	public UsrTrainerController(ProfileService profileService, TrainerInfoService trainerInfoService,MemberService memberService,  Req req) {
		this.profileService = profileService;
		this.trainerInfoService = trainerInfoService;
		this.memberService = memberService;
		this.req = req;
	}
	
	@GetMapping("/usr/trainer/find")
	public String trainerFind(Model model, @RequestParam(defaultValue = "2") int authLevel) {
		int loginedMemberId = req.getLoginedMember().getId();

	    List<Member> member = memberService.getTrainerById(authLevel);

	    // 트레이너 정보 가져오기
	    if (req.getLoginedMember().getAuthLevel() == 2) {
	        TrainerInfo trainerInfo = trainerInfoService.getTrainerInfoByProfileId(loginedMemberId);
	        model.addAttribute("trainerInfo", trainerInfo);
	    }
	    
	    String address = req.getLoginedMember().getAddress();

	    if (address == null || address.trim().isEmpty()) {
	        model.addAttribute("errorMsg", "주소 정보가 없습니다.");
	        return "usr/trainer/find";
	    }

	    String apiUrl = "https://dapi.kakao.com/v2/local/search/address.json?query=" + address;

	    HttpHeaders headers = new HttpHeaders();
	    headers.set("Authorization", "KakaoAK 48bfc1fd4bb0e476d73e0c40a374490a");
	    HttpEntity<String> entity = new HttpEntity<>(headers);

	    RestTemplate restTemplate = new RestTemplate();
	    ResponseEntity<Map> response = restTemplate.exchange(apiUrl, HttpMethod.GET, entity, Map.class);

	    List<Map<String, Object>> documents = (List<Map<String, Object>>) response.getBody().get("documents");

	    if (documents != null && !documents.isEmpty()) {
	        Map<String, Object> first = documents.get(0);
	        
	        String x = (String) first.get("x");
	        String y = (String) first.get("y");

	        model.addAttribute("lng", x);
	        model.addAttribute("lat", y);
	    }
	    
	    model.addAttribute("address", address);

	    model.addAttribute("member", member);

	    return "usr/trainer/find";
	}
	
	
}