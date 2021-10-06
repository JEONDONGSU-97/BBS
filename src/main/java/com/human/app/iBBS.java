package com.human.app;

import java.util.ArrayList;

public interface iBBS {
	void doAddList(String title, String content, String writer, String passcode);
	void doDelList(int bbs_id);
	ArrayList<BBSrec> doViewList();
	void doUpdateList(int bbs_id, String title, String content);
	BBSrec getPost(int bbs_id);
	void insertMember(String name, String userId, String passcode);
	int doCheckMember(String userId, String passcode);
}
