--高速决斗技能-先见之明
Duel.LoadScript("speed_duel_common.lua")
function c100730052.initial_effect(c)
	aux.SpeedDuelAtMainPhaseNoCountLimit(c,c100730052.skill,c100730052.con,aux.Stringid(100730052,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730052.filter(c)
	return c:GetFlagEffect(100730052)==0 and c:GetFlagEffectLabel(100730052)~=c:GetFieldID() and c:IsFacedown()
end

function c100730052.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return Duel.IsExistingMatchingCard(c100730052.filter,tp,LOCATION_DECK,LOCATION_DECK,1,nil)
		and Duel.GetTurnCount(tp)<=5
end

function c100730052.reg(c)
	c:RegisterFlagEffect(100730052,RESET_EVENT+RESETS_STANDARD+EVENT_FLIP,0,1,c:GetFieldID())
end
function c100730052.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730052)
	local op=Duel.SelectOption(tp,aux.Stringid(100730052,1),aux.Stringid(100730052,2))
	if op==0 then
		local g1=Duel.GetDecktopGroup(tp,1)
		if not g1 or g1:GetCount()==0 then return end
		g1:ForEach(c100730052.reg)
		Duel.ConfirmCards(tp,g1)
	elseif op==1 then
		local g2=Duel.GetDecktopGroup(1-tp,1)
		if not g2 or g2:GetCount()==0 then return end
		g2:ForEach(c100730052.reg)
		Duel.ConfirmCards(tp,g2)
	end
end
function c100730052.adjustop(e,tp)
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