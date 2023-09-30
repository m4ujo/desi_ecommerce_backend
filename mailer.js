const nodemailer = require('nodemailer');

const sendMail = (email, fullName, password) => {
    var transporter = nodemailer.createTransport({
        host: 'sandbox.smtp.mailtrap.io',
        port: 2525,
        auth: {
          user: 'ba5ffb26db7875',
          pass: 'ef6e1ade7aa333'
        }
      });

    const mailOptions = {
        from: 'DESI <ecommerce.desi@gmail.com>',
        to: email,
        subject: 'DESI Password Reset',
        html: 
        `
        <head>
            <style>
                body {
                    font-size: 16px;
                    font-family: Arial, Helvetica, sans-serif;
                    color: #333;
                }

                main { 
                    display: flex; 
                    justify-content: center;
                }

                section {
                    padding: 15px; width: 500px;
                    background-color: #f1f0ed; 
                }

                div {
                    padding: 15px; 
                    background-color: #fff; 
                }

                .password-box {
                    display: inline-block;
                    padding: 5px;
                    border-radius: 4px;
                    border: 1px dashed #ccc;
                    background-color: #f1f1f1;
                }
        
                .password-box p { 
                    padding: 0; 
                    margin: 0;
                    color: #555;
                } 

                figure {
                    margin: 0 auto;
                    padding: 0;
                    width: 200px;
                }
        
                figure img { 
                    display: inline-block;
                    width: 100%;
                    height: auto;
                }
            </style>
        </head>

        <body>
            <main>
                <section>
                    <div>
                        <h1>Restablece tu contraseña</h1> 
                        <p>Hola 👋 <strong>${fullName}</strong>,</p>
            
                        <p>Te hemos enviado este correo porque has solicitado cambiar tu contraseña</p>

                        <p>Esta es tu nueva contraseña:</p>

                        <div class='password-box'>
                            <p>${password}</p>
                        </div>
                                        
                        <p><strong>— The DESI team</strong></p>
                    </div>
                </section>
            </main>
        </body>
        `
    };
    
    transporter.sendMail(mailOptions, (error, info) => {
        if (error) {
            console.error(error);
        } else {
            console.log('Email send:' + info.response);
        }
    });
}

module.exports = { sendMail };