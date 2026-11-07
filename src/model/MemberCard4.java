package model;

import java.time.LocalDate;
import java.util.concurrent.ThreadLocalRandom;

public class MemberCard4 {
    private String membershipCode;
    private LocalDate membershipRegistrationDate;
    private Integer rewardPoints;

    public MemberCard4() {
        this.membershipCode = "MC" + String.format("%08d", ThreadLocalRandom.current().nextInt(100_000_000));
        this.membershipRegistrationDate = LocalDate.now();
        this.rewardPoints = 0;
    }

    public String getMembershipCode() {
        return membershipCode;
    }

    public void setMembershipCode(String membershipCode) {
        this.membershipCode = membershipCode;
    }

    public LocalDate getMembershipRegistrationDate() {
        return membershipRegistrationDate;
    }

    public void setMembershipRegistrationDate(LocalDate membershipRegistrationDate) {
        this.membershipRegistrationDate = membershipRegistrationDate;
    }

    public Integer getRewardPoints() {
        return rewardPoints;
    }

    public void setRewardPoints(Integer rewardPoints) {
        this.rewardPoints = rewardPoints;
    }
}
