package com.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Properties;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MyServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private Map<String, MyAction> map = new HashMap<String, MyAction>();

	// #1. XML 파싱
	// #2. JSON 파싱
	// #3. properties 파싱 (Map구조이다. 읽고 저장해내기가 정말 수월하므로 입문자에게 추천하는 방식)
	// 단, #3은 한글 문자열 삽입 시에만 조심하면 된다.

	@Override
	public void init(ServletConfig config) throws ServletException {
		//서버 켜질 때 최초 1회 실행
		super.init(config);

		ServletContext context = getServletContext();
		String pathname = config.getInitParameter("configFile");
		if (pathname == null) {
			throw new ServletException("<init-param> error !!!");
		}
		pathname = context.getRealPath(pathname);

		File f = new File(pathname);
		if (!f.exists()) {
			throw new ServletException(pathname + ": file not found ...");
		}

		Properties p = new Properties();
		try (FileInputStream fis = new FileInputStream(f)) {
			p.load(fis);
		} catch (Exception e) {
			throw new ServletException(e);
		}

		// config.properties에 저장된 클래스 이름의 객체를 생성하여 map에 저장한다.
		try {
			Iterator<Object> it = p.keySet().iterator();
			String className;
			while (it.hasNext()) {
				String key = (String) it.next();
				className = p.getProperty(key).trim();
				// 객체 생성하기
				Class<?> cls = Class.forName(className);
				//Object형으로 만들어진 객체를 MyAction클래스형으로 캐스팅하였음.
				MyAction action = (MyAction) cls.newInstance();
				// 생성된 객체를 map에 저장하기ㅏ
				map.put(key, action);
			}
		} catch (ClassNotFoundException e) {
			throw new ServletException(e);
		} catch (Exception e) {
			throw new ServletException(e);
		}

	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		process(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		process(req, resp);
	}

	protected void process(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		
		MyAction action = null;
		
		try {
			String uri = req.getRequestURI();
			System.out.println(uri);//contextPath 존재
			//contextPath 제거 구문
			if(uri.indexOf(req.getContextPath())==0) {
				uri= uri.substring(req.getContextPath().length());//contextPath를 제외
			}
			System.out.println(uri);
			//uri에서 /*.do 제거
			if(uri.lastIndexOf("/")>=0) {
				uri = uri.substring(0,uri.lastIndexOf("/"));
				//bbs, guset => key값 추출 (board, guest)
			}
			
			action = map.get(uri); // bbs나 guest에 해당하는 클래스 추출
			action.execute(req, resp); // 해당하는 클래스의 execute 메서드 호출
		} catch (Exception e) {
			throw new ServletException(e);
		}
	}

}
