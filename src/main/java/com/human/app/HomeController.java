package com.human.app;

import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	private HttpSession session;
	@Autowired
	private SqlSession sqlSession;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
//	@RequestMapping(value = "/", method = RequestMethod.GET)
//	public String home(Locale locale, Model model) {
//		logger.info("Welcome home! The client locale is {}.", locale);
//		
//		Date date = new Date();
//		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
//		
//		String formattedDate = dateFormat.format(date);
//		
//		model.addAttribute("serverTime", formattedDate );
//		
//		return "home";
//	}
	
	@RequestMapping(value = "/login_check", method = RequestMethod.POST)
	public String checkMember(HttpServletRequest hsr) {
		String userId = hsr.getParameter("loginid");
		String passcode = hsr.getParameter("passcode");
		iBBS bbs = sqlSession.getMapper(iBBS.class);
		int n = bbs.doCheckMember(userId, passcode);
		if(n>0) {
			session = hsr.getSession();
			session.setAttribute("userid", userId);
			return "redirect:/list";
		} else {
			return "login";
		}	
	}
	
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String selectBBS(HttpServletRequest hsr, Model model) {
		iBBS bbs = sqlSession.getMapper(iBBS.class);
		ArrayList<BBSrec> alBBS = bbs.doViewList();
		HttpSession session = hsr.getSession();
		String userid = (String)session.getAttribute("userid");
		System.out.println("Userid ["+userid+"]");
		if(userid == null || userid.equals("")) {
			model.addAttribute("loggined","0");
		} else {
			model.addAttribute("loggined","1");
			model.addAttribute("userid",userid);
		}
		model.addAttribute("list_BBS", alBBS);
		return "list";
	}
	
	@RequestMapping(value="/ReplyControl", method = RequestMethod.POST)
	@ResponseBody
	public String doReplyControl(HttpServletRequest hsr) {
		String optype = hsr.getParameter("optype");
		String reply_content = hsr.getParameter("reply_content");
		int bbs_id = Integer.parseInt(hsr.getParameter("bbs_id"));
		HttpSession s = hsr.getSession();
		String userid = (String) s.getAttribute("userid");
		if(optype.equals("add")) {
			// MyBatis 호출.
		} else if(optype.equals("delete")) { // 댓글 삭제			
		} else if(optype.equals("update")) { // 댓글 수정
		}
		return "ok";
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String loginBBS() {
		return "login";
	}
	
	@RequestMapping(value="/logout")
	public String logout(HttpServletRequest hsr) {
		session=hsr.getSession();
		session.invalidate();
		return "redirect:/list";
	}
	public boolean loginUser(HttpServletRequest hsr) {
		HttpSession s = hsr.getSession();
		String userid=(String) s.getAttribute("userid");
		if(userid == null || userid.equals("")) return false;
		return true;
	}
	
	@RequestMapping(value = "/newbie_check", method = RequestMethod.POST)
	public String newbieCheck(HttpServletRequest hsr) {
		iBBS bbs = sqlSession.getMapper(iBBS.class);
		String userName = hsr.getParameter("realName");	
		String userId = hsr.getParameter("loginId");
		String passcode = hsr.getParameter("password");
		bbs.insertMember(userName, userId, passcode);
		return "redirect:/login";
	}
	
	@RequestMapping(value = "/newbie", method = RequestMethod.GET)
	public String newbie() {
		return "newbie";
	}
	
	@RequestMapping(value = "/view/{bbs_id}", method = RequestMethod.GET)
	public String selectOneBBS(@PathVariable("bbs_id") int bbs_id, 
			HttpServletRequest hsr,Model model) {
		iBBS bbs = sqlSession.getMapper(iBBS.class);
		BBSrec post = bbs.getPost(bbs_id);
		model.addAttribute("post", post);
		session=hsr.getSession();
		String userid=(String) session.getAttribute("userid");
		model.addAttribute("userid",userid);
		return "view";
	}
	
	
	@RequestMapping(value = "/new", method = RequestMethod.GET)
	public String brandNew() {
		//
		return "new";
	}

	@RequestMapping(value = "/save", method = RequestMethod.POST, 
			produces = "application/text; charset=utf8")
//	@ResponseBody
	public String insertBBS(HttpServletRequest request) {
		String title = request.getParameter("title");
		String content = request.getParameter("content");		
		String writer = request.getParameter("writer");	
		String passcode = request.getParameter("passcode");
		iBBS bbs = sqlSession.getMapper(iBBS.class);
		bbs.doAddList(title, content, writer, passcode);
		System.out.print("title = "+title+", content = "+content+", writer = "+writer+", passcode = "+passcode);
		
		return "redirect:/list";
	}
	
	@RequestMapping(value = "/update_view/{bbs_id}", method = RequestMethod.GET) //DB에 
	public String updateBBS(@PathVariable("bbs_id") int bbs_id, Model model) {
		iBBS bbs = sqlSession.getMapper(iBBS.class);
		BBSrec post = bbs.getPost(bbs_id);
		model.addAttribute("post", post);
		return "update";
	}
	
	@RequestMapping(value = "/update", method = RequestMethod.POST,
			produces = "application/text; charset=utf8")
	public String updateBBS1(HttpServletRequest request) {
		int bbs_id = Integer.parseInt(request.getParameter("bbs_id1"));
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		iBBS bbs = sqlSession.getMapper(iBBS.class);
		bbs.doUpdateList(bbs_id, title, content);
		System.out.print("bbs_id = "+bbs_id);
		return "redirect:/list";
	}
	
	@RequestMapping(value = "/delete/{bbs_id}", method = RequestMethod.GET)
	public String deleteBBS(@PathVariable("bbs_id") int bbs_id) {
		iBBS bbs = sqlSession.getMapper(iBBS.class);
		bbs.doDelList(bbs_id);	
		System.out.print("bbs_id = "+bbs_id);
		return "redirect:/list";
	}
	
	@RequestMapping(value = "/select", method = RequestMethod.POST)
	public String selectBBS(HttpServletRequest request) {
		if(!checkLogin(request)) return "redirect:/list";
		int bbs_id = Integer.parseInt(request.getParameter("bbs_id"));
		iBBS bbs = sqlSession.getMapper(iBBS.class);
		bbs.doViewList();
		return "redirect:/list";
	}
	
	public boolean checkLogin(HttpServletRequest hsr) {
		HttpSession session = hsr.getSession();
		String userid = (String)session.getAttribute("userid");
		if(userid==null || userid.equals("")) return false;
		else return true;
	}
}
