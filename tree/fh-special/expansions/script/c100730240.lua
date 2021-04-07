--高速决斗技能-未来命运
Duel.LoadScript("speed_duel_common.lua")
function c100730240.initial_effect(c)
	aux.SpeedDuelAtMainPhaseNoCountLimit(c,c100730240.skill,c100730240.con,aux.Stringid(100730240,0))
	aux.SpeedDuelBeforeDraw(c,c100730240.skill2)
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730240.filter(c)
	return c:GetFlagEffect(100730240)==0 and c:GetFlagEffectLabel(100730240)~=c:GetFieldID() and c:IsFacedown()
end
function c100730240.filter2(c)
	return c:IsSetCard(0x31) and c:IsFaceup() and c:IsType(TYPE_MONSTER)
end
function c100730240.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return Duel.IsExistingMatchingCard(c100730240.filter,tp,LOCATION_DECK,LOCATION_DECK,1,nil)
		and Duel.IsExistingMatchingCard(c100730240.filter2,tp,LOCATION_MZONE,0,2,nil)
end

function c100730240.reg(c)
	c:RegisterFlagEffect(100730240,RESET_EVENT+RESETS_STANDARD+EVENT_FLIP,0,1,c:GetFieldID())
end
function c100730240.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730240)
	local op=Duel.SelectOption(tp,aux.Stringid(100730240,1),aux.Stringid(100730240,2))
	if op==0 then
		local g1=Duel.GetDecktopGroup(tp,1)
		if not g1 or g1:GetCount()==0 then return end
		g1:ForEach(c100730240.reg)
		Duel.ConfirmCards(tp,g1)
	elseif op==1 then
		local g2=Duel.GetDecktopGroup(1-tp,1)
		if not g2 or g2:GetCount()==0 then return end
		g2:ForEach(c100730240.reg)
		Duel.ConfirmCards(tp,g2)
	end
end
function c100730240.adjustop(e,tp)
	local g1=Duel.GetDecktopGroup(tp,1)
	if not g1 or g1:GetCount()==0 then return end
	local fc=g1:GetFirst()
	if fc:IsPosition(POS_FACEUP_DEFENSE) then return end
	fc:ReverseInDeck()
	local g2=Duel.GetDecktopGroup(1-tp,1)
	if not g2 or g2:GetCount()==0 then return end
	local fc=g2:GetFirst()
	if fc:IsPosition(POS_FACEUP_DEFENSE) then return end
	fc:ReverseInDeck()
end
function c100730240.skill2(e,tp)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730240)
	local c=Duel.CreateToken(tp,68663748)
	Duel.SendtoHand(c,tp,REASON_RULE)
	e:Reset()
end