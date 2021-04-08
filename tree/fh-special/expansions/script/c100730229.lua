--高速决斗技能-受伤的英雄
Duel.LoadScript("speed_duel_common.lua")
function c100730229.initial_effect(c)
	if not c100730229.UsedLP then
		c100730229.UsedLP={}
		c100730229.UsedLP[0]=0
		c100730229.UsedLP[1]=0
	end
	aux.SpeedDuelCalculateDecreasedLP()
	aux.SpeedDuelAtMainPhase(c,c100730229.skill,c100730229.con,aux.Stringid(100730229,1))
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730229.skill(e,tp,eg,ep,ev,re,r,rp)
	tp = e:GetLabelObject():GetOwner()
	if Duel.SelectYesNo(tp,aux.Stringid(100730229,0)) then
		Duel.Hint(HINT_CARD,1-tp,100730229)
		c100730229.UsedLP[tp]=c100730229.UsedLP[tp]+2500
		local g=Duel.GetMatchingGroup(c100730229.filter,tp,LOCATION_DECK,0,nil)
		local c=g:Select(tp,1,1,nil)
		if not c or g:GetCount()==0 then return end
		Duel.SpecialSummon(c,0,tp,tp,true,true,POS_FACEUP_ATTACK)
	end
end

function c100730229.con(e,tp,eg,ep,ev,re,r,rp)
	tp = e:GetLabelObject():GetOwner()
	return Duel.GetTurnPlayer()==tp
		and aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.GetMatchingGroupCount(Card.IsSetCard,tp,LOCATION_DECK,0,nil,0x3008)>2
		and aux.DecreasedLP[tp]-c100730229.UsedLP[tp] >= 2500
end
function c100730229.filter(c)
	return c:IsAttackBelow(2500) and c:IsSetCard(0x3008)
end