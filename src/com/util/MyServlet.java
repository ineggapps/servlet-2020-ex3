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

	// #1. XML �Ľ�
	// #2. JSON �Ľ�
	// #3. properties �Ľ� (Map�����̴�. �а� �����س��Ⱑ ���� �����ϹǷ� �Թ��ڿ��� ��õ�ϴ� ���)
	// ��, #3�� �ѱ� ���ڿ� ���� �ÿ��� �����ϸ� �ȴ�.

	@Override
	public void init(ServletConfig config) throws ServletException {
		//���� ���� �� ���� 1ȸ ����
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

		// config.properties�� ����� Ŭ���� �̸��� ��ü�� �����Ͽ� map�� �����Ѵ�.
		try {
			Iterator<Object> it = p.keySet().iterator();
			String className;
			while (it.hasNext()) {
				String key = (String) it.next();
				className = p.getProperty(key).trim();
				// ��ü �����ϱ�
				Class<?> cls = Class.forName(className);
				//Object������ ������� ��ü�� MyActionŬ���������� ĳ�����Ͽ���.
				MyAction action = (MyAction) cls.newInstance();
				// ������ ��ü�� map�� �����ϱ⤿
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
			System.out.println(uri);//contextPath ����
			//contextPath ���� ����
			if(uri.indexOf(req.getContextPath())==0) {
				uri= uri.substring(req.getContextPath().length());//contextPath�� ����
			}
			System.out.println(uri);
			//uri���� /*.do ����
			if(uri.lastIndexOf("/")>=0) {
				uri = uri.substring(0,uri.lastIndexOf("/"));
				//bbs, guset => key�� ���� (board, guest)
			}
			
			action = map.get(uri); // bbs�� guest�� �ش��ϴ� Ŭ���� ����
			action.execute(req, resp); // �ش��ϴ� Ŭ������ execute �޼��� ȣ��
		} catch (Exception e) {
			throw new ServletException(e);
		}
	}

}
