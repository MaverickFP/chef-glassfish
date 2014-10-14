chef-glassfish
======================

Semplice repository che mostra come configurare glassfish mediante chef.

Vagrant
-------
Vagrant e' un sistema usato per creare e configurare macchine virtuali.  Per usare questo progetto e' necessario avere: 

 * download [VirtualBox](https://www.virtualbox.org/wiki/Downloads) (used by Vagrant)
 * download [Vagrant](http://downloads.vagrantup.com/)

Avvio ed uso della macchina virtuale
----------------------------------
1. Fare il download che software appena menzionato (VirtualBox e Vagrant).
2. Clonare questo repository.
3. Lanciare il comando ```vagrant up``` dal repository che avete clonato
4. Dopo alcuni minuti la macchina virtuale verra' creata e avviata con Glassfish come servizio
5. E' possibile accedere nella macchina virtuale mediante ul comando ```vagrant ssh```

**Accesso al server:**

 * Glassfish console: http://localhost:4848