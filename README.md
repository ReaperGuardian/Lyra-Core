# 🛡️ PROJECT: LYRA ARASAKA
### [ SECURITY CLEARANCE: LEVEL 5 ] — HOST: ReaperGuardian

Welcome to the **Arasaka Intel Net** mobile terminal environment. This repository serves as the central vault for the **Lyra-Core** ignition scripts, optimized for the Samsung Galaxy Tab Active 3 mobile penetration testing unit.

---

## 🛠️ SYSTEM SPECIFICATIONS
- **Codename:** LYRA
- **Operator:** ReaperGuardian
- **Platform:** Android / Termux
- **UI Framework:** Precision-ANSI v8.7 (Box UI)
- **Features:** Real-time Hardware Telemetry (PWR/TEMP/SIG)

---

## 🚀 MASTER INSTALLATION PROTOCOL
To deploy or update the **LYRA HUD** on any node, paste the following command into your Termux terminal:

```bash
pkg install curl termux-api -y && mkdir -p ~/scripts && curl -sL [https://raw.githubusercontent.com/ReaperGuardian/Lyra-Core/main/ignition.sh](https://raw.githubusercontent.com/ReaperGuardian/Lyra-Core/main/ignition.sh) -o ~/scripts/ignition.sh && chmod +x ~/scripts/ignition.sh && ~/scripts/ignition.sh

 QUICK-ACCESS SHORTCUT
​After the initial installation, run this command once to enable the lyra shortcut:
echo "alias lyra='bash ~/scripts/ignition.sh'" >> ~/.bashrc && source ~/.bashrc
Now, simply type lyra from any directory to engage the HUD.
This toolkit is for authorized security auditing and educational purposes only. Unauthorized use of these tools is a violation of corporate policy.
​"Reliability. Security. Arasaka."
