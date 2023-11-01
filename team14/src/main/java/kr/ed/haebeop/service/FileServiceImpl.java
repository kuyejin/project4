package kr.ed.haebeop.service;

import kr.ed.haebeop.domain.FileDTO;
import kr.ed.haebeop.domain.FileVO;
import kr.ed.haebeop.repository.FileRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class FileServiceImpl implements FileService {

    @Autowired
    FileRepository fileRepository;

    @Override
    public void insertFileboard(FileVO fileboard) throws Exception {
        fileRepository.insertFileboard(fileboard);
    }

    @Override
    public List<FileVO> getFileList() throws Exception {
        return fileRepository.getFileList();
    }

    @Override
    public List<FileDTO> getFileGroupList(int postNo) throws Exception {
        return fileRepository.getFileGroupList(postNo);
    }

    @Override
    public FileVO getFilebord(int postNo) throws Exception {
        return fileRepository.getFilebord(postNo);
    }

    @Override
    public FileVO getFileObject(int no) throws Exception {
        return null;
    }

    @Override
    public void removeFileboard(int postNo) throws Exception {
        fileRepository.removeFileboard(postNo);
    }

    @Override
    public void fileRemove(int no) throws Exception {
        fileRepository.fileRemove(no);
    }

    @Override
    public FileDTO getFile(int no) throws Exception {
        return fileRepository.getFile(no);
    }

    @Override
    public void updateFileboard(FileVO fileboard) throws Exception {
        fileRepository.updateFileboard(fileboard);
    }
    @Override
    public void removeFileAll(int postNo) throws Exception {
        fileRepository.removeFileAll(postNo);
    }

    @Override
    public void countUp(int postNo) throws Exception {
        fileRepository.countUp(postNo);
    }
}