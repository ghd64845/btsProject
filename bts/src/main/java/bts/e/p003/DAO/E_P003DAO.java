package bts.e.p003.DAO;

import java.util.List;

import org.springframework.dao.DataAccessException;

import bts.e.p003.VO.E_P003VO;
import bts.e.p003.VO.E_P003VO_2;

public interface E_P003DAO {
	public void insertAcc(E_P003VO e_p003VO) throws DataAccessException;
	public void insertTag(List<E_P003VO_2> list) throws DataAccessException;
}
