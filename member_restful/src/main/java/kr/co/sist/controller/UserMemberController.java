package kr.co.sist.controller;

import java.util.HashMap;
import java.util.Map;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import kr.co.sist.service.UserMemberService;

@RestController//모든 응답은 JSP가 아닌 내용 자체가 응답된다. @ResponseBody 를 사용한 것과 동일
@RequestMapping("/api/users")
public class UserMemberController {

	private Map<String, String> usersMap=new HashMap<String, String>();
	
	@Autowired(required = false)
	private UserMemberService ums;
	
	@PostMapping
	public String createUser(@RequestParam String userId, @RequestParam String name) {//@RequestParam 써도되고 안써도 됨
		int cnt=ums.addMember(usersMap, userId, name);
		JSONObject jsonObj=new JSONObject();
		jsonObj.put("msg","계정생성 실패");
		if(cnt == 1) {
			jsonObj.put("msg","계정생성 성공");
		}
		return jsonObj.toJSONString();
	}//createUser
	
	@GetMapping("/{userId}")
	public String getUser(@PathVariable String userId) {
		String jsonObj=ums.searchMember(usersMap, userId);
		return jsonObj;
	}
	
	@GetMapping("/all")
	public String getAllUser() {
		String jsonObj=ums.searchAllMember(usersMap);
		return jsonObj;
	}
	
	@PutMapping("/{userId}")
	public String updateUser(@PathVariable String userId, @RequestParam String name) {//@PathVariable 제일 마지막에 있는 uri 가져옴
		String jsonObj=ums.updateMember(usersMap, userId, name);
		
		return jsonObj;
	}//createUser
	
	@DeleteMapping("/{userId}")
	public String deleteUser(@PathVariable String userId) {
		String jsonObj=ums.deleteMember(usersMap, userId);
		
		return jsonObj;
	}//createUser
	
}
