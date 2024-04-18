package com.springboot.myapp.backupFactory;

import org.apache.commons.compress.archivers.zip.ZipArchiveEntry;
import org.apache.commons.compress.archivers.zip.ZipArchiveOutputStream;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Arrays;
import java.util.concurrent.atomic.AtomicLong;
import java.util.logging.Logger;

@Service
public class backupService {

    private static final Logger logger = Logger.getLogger(backupService.class.getName());
    private static final String BACKUP_DIR = "W:\\file";
    private static final String SOURCE_DIR = "C:\\Users\\admin\\Desktop\\정리\\4. 개발\\pj\\eds\\eds_erp\\src\\main";

//    @Scheduled(cron = "00 12 13 * * ?")  // 테스트 스케줄러 실행
    @Scheduled(cron = "0 0 12,19 * * ?")  // 실서버 스케줄러 실행
    public void performBackup() throws IOException {
        LocalDateTime now = LocalDateTime.now();
        String formattedDateTime = now.format(DateTimeFormatter.ofPattern("yyyyMMdd_HHmmss"));
        File backupDir = new File(BACKUP_DIR);

        if (!backupDir.exists()) {
            backupDir.mkdirs();
            logger.info("Created backup directory: " + BACKUP_DIR);
        }

        String baseFileName = BACKUP_DIR + "/programBackup_" + formattedDateTime;
        File backupFile = new File(baseFileName + ".zip");

        backupFile = resolveFileName(backupFile);

        try {
            compressDirectory(new File(SOURCE_DIR), backupFile);
            logger.info("Backup completed successfully to " + backupFile.getPath());
            manageBackupFiles(backupDir, 28); // 백업 파일 개수 관리
        } catch (IOException e) {
            logger.severe("Failed to complete backup: " + e.getMessage());
        }
    }

    private void manageBackupFiles(File directory, int maxFiles) {
        File[] files = directory.listFiles();
        if (files != null && files.length > maxFiles) {
            Arrays.sort(files, (f1, f2) -> Long.compare(f1.lastModified(), f2.lastModified())); // 수정된 시간을 기준으로 오름차순 정렬
            int filesToDelete = files.length - maxFiles;
            for (int i = 0; i < filesToDelete; i++) {
                if (files[i].delete()) {
                    logger.info("Deleted old backup file: " + files[i].getName());
                } else {
                    logger.warning("Failed to delete old backup file: " + files[i].getName());
                }
            }
        }
    }

    private File resolveFileName(File baseFile) {
        if (!baseFile.exists()) {
            return baseFile;
        }
        int count = 0;
        File newFile;
        do {
            count++;
            String fileName = String.format("%s_%d.zip", baseFile.getAbsolutePath().replace(".zip", ""), count);
            newFile = new File(fileName);
        } while (newFile.exists());
        return newFile;
    }

    private void compressDirectory(File directory, File outputFile) throws IOException {
        try (ZipArchiveOutputStream archive = new ZipArchiveOutputStream(new FileOutputStream(outputFile))) {
            Files.walk(directory.toPath())
                    .filter(path -> !Files.isDirectory(path))
                    .forEach(path -> {
                        String relativePath = directory.toPath().relativize(path).toString();
                        ZipArchiveEntry entry = new ZipArchiveEntry(relativePath);
                        try (FileInputStream fis = new FileInputStream(path.toFile())) {
                            archive.putArchiveEntry(entry);
                            fis.transferTo(archive);
                            archive.closeArchiveEntry();
                        } catch (IOException e) {
                            throw new RuntimeException("Error processing file: " + path, e);
                        }
                    });
            archive.finish();
        }
    }
}