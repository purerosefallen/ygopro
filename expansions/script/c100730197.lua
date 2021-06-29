--高速决斗技能-受伤的英雄
Duel.LoadScript("speed_duel_common.lua")
function c100730197.initial_effect(c)
	if not c100730197.UsedLP then
		c100730197.UsedLP={}
		c100730197.UsedLP[0]=0
		c100730197.UsedLP[1]=0
	end
	aux.SpeedDuelCalculateDecreasedLP()
	aux.SpeedDuelAtMainPhase(c,c100730197.skill,c100730197.con,aux.Stringid(100730197,1))
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730197.skill(e,tp,eg,ep,ev,re,r,rp)
	tp = e:GetLabelObject():GetOwner()
	if Duel.SelectYesNo(tp,aux.Stringid(100730197,0)) then
		Duel.Hint(HINT_CARD,1-tp,100730197)
		c100730197.UsedLP[tp]=c100730197.UsedLP[tp]+2000
		local g=Duel.GetMatchingGroup(c100730197.filter,tp,LOCATION_DECK,0,nil)
		local c=g:Select(tp,1,1,nil)
		if not c or g:GetCount()==0 then return end
		Duel.SpecialSummon(c,0,tp,tp,true,true,POS_FACEUP_ATTACK)
	end
end

function c100730197.con(e,tp,eg,ep,ev,re,r,rp)
	tp = e:GetLabelObject():GetOwner()
	return Duel.GetTurnPlayer()==tp
		and aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.GetMatchingGroupCount(Card.IsSetCard,tp,LOCATION_DECK,0,nil,0x3008)>0
		and aux.DecreasedLP[tp]-c100730197.UsedLP[tp] >= 2000
end
function c100730197.filter(c)
	return c:IsAttackBelow(2500) and c:IsSetCard(0x3008)
end