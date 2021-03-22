--高速决斗技能-融合储备·机人
Duel.LoadScript("speed_duel_common.lua")
function c100730173.initial_effect(c)
	if not c100730173.UsedLP then
		c100730173.UsedLP={}
		c100730173.UsedLP[0]=0
		c100730173.UsedLP[1]=0
	end
	aux.SpeedDuelCalculateDecreasedLP()
	aux.SpeedDuelAtMainPhase(c,c100730173.operation,c100730173.con,aux.Stringid(100730173,0))
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c100730173.operation)
	c:RegisterEffect(e1)
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730173.filter1(c,tp)
	return Duel.IsExistingMatchingCard(c100730173.filter2,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil,c)
end
function c100730173.filter2(c,fc)
	return aux.IsMaterialListCode(fc,c:GetCode())
end
function c100730173.con(e,tp,eg,ep,ev,re,r,rp,chk)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(c100730173.filter1,tp,LOCATION_EXTRA,0,1,nil,tp)
		and aux.DecreasedLP[tp]-c100730173.UsedLP[tp]>=1500
end
function c100730173.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
	local cg=Duel.SelectMatchingCard(tp,c100730173.filter1,tp,LOCATION_EXTRA,0,1,1,nil,tp)
	if cg:GetCount()==0 then return end
	Duel.ConfirmCards(1-tp,cg)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c100730173.filter2),tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil,cg:GetFirst())
	local tc=g:GetFirst()
	if not tc then return end
	if Duel.SendtoHand(tc,nil,REASON_EFFECT)~=0 and tc:IsLocation(LOCATION_HAND) then
		Duel.ConfirmCards(1-tp,tc)
	end
end
function c100730173.sumlimit(e,c)
	return c:IsCode(e:GetLabel())
end