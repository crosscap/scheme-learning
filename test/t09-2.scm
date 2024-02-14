(define (my-copy-file input-file output-file)
    (let ((inp (open-input-file input-file)) (outp (open-output-file output-file)))
        (let loop((inc (read-char inp)))
            (if (eof-object? inp)
                (begin
                    (close-input-port input-file)
                    (close-output-port output-file))
                (begin
                    (display inp output-file)
                    (loop (read-char inp)))))))
